const { Router } = require("express");
const axios = require("axios");
const moment = require('moment');

const router = Router();

function getTodaysDate() {
  let month = moment().utcOffset("-05:00").format("MM");
  let day = moment().utcOffset("-05:00").format("DD");
  let year = moment().utcOffset("-05:00").format("YYYY");
  today = year + month+ day;
  console.log(today);
  return today;
}
let games = [];

function getDailyOdds() {
  axios({
    method: "get",
    url: `https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/date/${this.getTodaysDate()}/odds_gamelines.json`,
    auth: {
      username: "3740dd52-6108-4ef0-b3d8-c79dc1",
      password: "MYSPORTSFEEDS"
    }
  }).then(function(response) {
    console.log("odds", response);
  });
}

getTeamPoints = winPct => {
  let teamPoints = 0;
  if (winPct >= 0.6) {
    return (teamPoints = 10);
  }
  if (winPct >= 0.55) {
    return (teamPoints = 8);
  }
  if (winPct >= 0.5) {
    return (teamPoints = 6);
  }
  if (winPct >= 0.45) {
    return (teamPoints = 5);
  }
  if (winPct >= 0.4) {
    return (teamPoints = 3);
  }
  if (winPct >= 0.35) {
    return (teamPoints = 1);
  }
  if (winPct >= 0.3) {
    return (teamPoints = -1);
  }
  if (winPct >= 0.25) {
    return (teamPoints = -2);
  }
  if (winPct <= 0.2) {
    return (teamPoints = -3);
  }
};

getPitcherPoints = winPct => {
  let pitcherPoints;
  if (winPct >= 0.9) {
    return (pitcherPoints = 10);
  }
  if (winPct >= 0.85) {
    return (pitcherPoints = 8);
  }
  if (winPct >= 0.8) {
    return (pitcherPoints = 6);
  }
  if (winPct >= 0.75) {
    return (pitcherPoints = 4);
  }
  if (winPct >= 0.7) {
    return (pitcherPoints = 2);
  }
  if (winPct >= 0.65) {
    return (pitcherPoints = 0);
  }
  if (winPct >= 0.5) {
    return (pitcherPoints = -2);
  }
  if (winPct >= 0.25) {
    return (pitcherPoints = -4);
  }
  if (winPct <= 0.2) {
    return (pitcherPoints = -6);
  }
};

function getStats() {
  let x;
  for (x = 0; x < games.length; x++) {
    if (!games[x].awayTeam.pitcher[0].stats || !games[x].awayTeam.teamStats) {
      getPitcherStats(x, "away", games[x].awayTeam.pitcher[0].player);
      getStandings(games[x].awayTeam.id, x, "away");
    }
    if (!games[x].homeTeam.pitcher[0].stats || !games[x].homeTeam.teamStats) {
      getPitcherStats(x, "home", games[x].homeTeam.pitcher[0].player);
      getStandings(games[x].homeTeam.id, x, "home");
    }
  }
}

function getStandings(teamId, game, team) {
  axios({
    method: "get",
    url: `https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/team_stats_totals.json?team=${teamId}`,
    auth: {
      username: "3740dd52-6108-4ef0-b3d8-c79dc1",
      password: "MYSPORTSFEEDS"
    }
  })
    .then(function(getStandingsResponse) {
      if (team === "home") {
        games[game].homeTeam.teamStats =
          getStandingsResponse.data.teamStatsTotals[0].stats;
        games[game].homeTeam.teamPoints = getTeamPoints(
          getStandingsResponse.data.teamStatsTotals[0].stats.standings.winPct
        );
      } else {
        games[game].awayTeam.teamStats =
          getStandingsResponse.data.teamStatsTotals[0].stats;
        games[game].awayTeam.teamPoints = getTeamPoints(
          getStandingsResponse.data.teamStatsTotals[0].stats.standings.winPct
        );
      }
    })
    .catch(error => {
      console.log("standings error");
    });
}

function getPitcherStats(game, team, pitcher) {
  if (pitcher.firstName) {
    axios({
      method: "get",
      url: `https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/player_stats_totals.json?player=${pitcher.firstName +
        "-" +
        pitcher.lastName +
        "-" +
        pitcher.id}`,
      auth: {
        username: "3740dd52-6108-4ef0-b3d8-c79dc1",
        password: "MYSPORTSFEEDS"
      }
    })
      .then(function(pitcherStatsResponse) {
        if (pitcherStatsResponse.data.playerStatsTotals[0].stats.pitching) {
          if (team === "home") {
            games[game].homeTeam.pitcher[0].stats =
              pitcherStatsResponse.data.playerStatsTotals[0].stats.pitching;
            games[game].homeTeam.pitcherPoints = getPitcherPoints(
              games[game].homeTeam.pitcher[0].stats.winPct
            );
          } else {
            games[game].awayTeam.pitcher[0].stats =
              pitcherStatsResponse.data.playerStatsTotals[0].stats.pitching;
            games[game].awayTeam.pitcherPoints = getPitcherPoints(
              games[game].awayTeam.pitcher[0].stats.winPct
            );
          }
        }
      })
      .catch(error => {
        console.log(pitcher.firstName);
        console.log("pitcher stats error");
        if (team === "home") {
          games[game].homeTeam.pitcher[0].stats = null;
          games[game].homeTeam.pitcherPoints = null;
        } else {
          games[game].awayTeam.pitcher[0].stats = null;
          games[game].awayTeam.pitcherPoints = null;
        }
      });
  } else {
    console.log("else");
  }
}

function getTotalPoints() {
  for (let i = 0; i < games.length; i++) {
    games[i].homeTeam.totalPoints =
      games[i].homeTeam.pitcherPoints + games[i].homeTeam.teamPoints;
    games[i].awayTeam.totalPoints =
      games[i].awayTeam.pitcherPoints + games[i].awayTeam.teamPoints;
  }
}

router.get("/dailygames", (request, response, next) => {
  games = [];
  axios
    .get(
      `https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/date/${getTodaysDate()}/games.json`,
      {
        auth: {
          username: "3740dd52-6108-4ef0-b3d8-c79dc1",
          password: "MYSPORTSFEEDS"
        }
      }
    )
    .then(dailyResponse => {
      let i;
      for (i = 0; i < dailyResponse.data.games.length; i++) {
        axios({
          method: "get",
          url: `https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/games/${getTodaysDate() +
            "-" +
            dailyResponse.data.games[i].schedule.awayTeam.abbreviation +
            "-" +
            dailyResponse.data.games[i].schedule.homeTeam
              .abbreviation}/lineup.json`,
          auth: {
            username: "3740dd52-6108-4ef0-b3d8-c79dc1",
            password: "MYSPORTSFEEDS"
          }
        })
          .then(lineUpResponse => {
            let game = lineUpResponse.data;
            // console.log(dailyResponse.data.games);
            // console.log(dailyResponse.data.games[i]);
            games.push({
              awayTeam: {
                id: game.teamLineups[0].team.id,
                abbreviation: game.teamLineups[0].team.abbreviation,
                pitcher: game.teamLineups[0].expected.lineupPositions.filter(
                  obj => {
                    return obj.position === "P";
                  }
                ),
                score: dailyResponse.data.games.filter(obj => {
                  return (
                    obj.schedule.awayTeam.abbreviation ===
                    game.teamLineups[0].team.abbreviation
                  );
                })
              },
              homeTeam: {
                id: game.teamLineups[1].team.id,
                abbreviation: game.teamLineups[1].team.abbreviation,
                pitcher: game.teamLineups[1].expected.lineupPositions.filter(
                  obj => {
                    return obj.position === "P";
                  }
                ),
                score: dailyResponse.data.games.filter(obj => {
                  return (
                    obj.schedule.awayTeam.abbreviation ===
                    game.teamLineups[0].team.abbreviation
                  );
                })
              }
            });
          })
          .then(res => {
            getStats();
          })
          .catch(getStatsError => {
            // console.log(getStatsError);
            console.log("there was an error");
          })
          .then(res2 => {
            setTimeout(() => getTotalPoints(), 10000);
          })
          .catch(lineUpError => {
            // console.log(lineUpError);
            console.log("there was an error");
          });
      }
    })
    .then(res => {
      setTimeout(() => response.status(200).json(games), 15000);
    })
    .catch(function(error) {
      // handle error
      console.log(error);
    });
});

module.exports = router;
