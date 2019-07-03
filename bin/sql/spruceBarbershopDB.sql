DROP TABLE users, services, staff, business_hours, specials, updates, waitlist;

CREATE TABLE waitlist(
  id serial,
  userID int,
  serviceID int,
  staffID int,
  waiting boolean,
  in_progress boolean,
  done boolean,
  date DATE,
  join_time TIME,
  start_time TIME,
  end_time TIME
);

CREATE TABLE admin(
  id serial,
  email character varying(50),
  password character varying(200)
);

CREATE TABLE users(
  id serial,
  first_name character varying(50),
  last_name character varying(50),
  email character varying(50),
  phone_number character varying(50),
  pictureUrl character varying(200),
  password character varying(200),
  owner boolean,
  staff boolean,
  customer boolean
);

CREATE TABLE services(
  id serial,
  type character varying(50),
  category character varying(50),
  name character varying(50),
  description text[],
  price int,
  time int
);

CREATE TABLE staff(
  id serial,
  userID int,
  stylist boolean,
  barber boolean,
  staffPicture character varying(200),
  monday_start TIME,
  monday_end TIME,
  tuesday_start TIME,
  tuesday_end TIME,
  wednesday_start TIME,
  wednesday_end TIME,
  thursday_start TIME,
  thursday_end TIME,
  friday_start TIME,
  friday_end TIME,
  saturday_start TIME,
  saturday_end TIME,
  sunday_start TIME,
  sunday_end TIME
);

CREATE TABLE business_hours(
  id serial,
  day character varying(50),
  hours character varying(50)
);

CREATE TABLE specials(
  id serial,
  type character varying(50),
  type_line2 character varying(50),
  special character varying(50)
);

CREATE TABLE updates(
  id serial,
  update character varying(200)
);

INSERT INTO specials(type, type_line2, special)
VALUES
('Military/Veteran', null, '$5 off all services'),
('First Responders', null, '$5 off all services'),
('Police/Fire Fighter', null, '$5 off all services'),
('Senior Citizen', null, '$5 off all services'),
('Thirsty Thursday', '10 am - 2 pm', '$5 off all services');

INSERT INTO business_hours(day, hours)
VALUES
('Sunday', 'Closed'),
('Monday', 'Closed'),
('Tuesday', '10 am - 8 pm'),
('Wednesday', '10 am - 8 pm'),
('Thursday', '10 am - 8 pm'),
('Friday', '10 am - 8 pm'),
('Saturday', '10 am - 4 pm');

INSERT INTO staff(userID, stylist, barber, staffPicture, monday_start, monday_end, tuesday_start, tuesday_end, wednesday_start,wednesday_end, thursday_start, thursday_end, friday_start, friday_end, saturday_start, saturday_end)
VALUES
(1, true, false, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/amber.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(2, false, true, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/riawna.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(3, false, true, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/nikki.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(4, false, true, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/morgan.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(5, false, true, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/mae.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(6, false, true, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/florido.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(7, false, true, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/amber.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(8, true, false, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/riawna.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(9, true, false, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/nikki.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(10, true, false, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/morgan.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(11, true, false, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/mae.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00'),
(12, true, false, 'https://www.ninezeroonesalon.com/wp-content/uploads/2016/07/florido.jpg', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00', '09:00:00', '17:00:00');

INSERT INTO services(type, category, name, description, price, time)
VALUES
('Barber', 'Hair', 'Spruce Haircut', '{"Personal consultation", "Tailored cut", "Steamed Towel", "Precision edge up with straight razor", "Refreshing Shampoo", "Finishing touch style"}', 3000, 30),
('Barber', 'Hair', 'Basic Buzz', '{"Personal consultation", "Cut with clippers only", "Steamed Towel", "Precision edge up with straight razor", "Refreshing Shampoo", "Finishing touch style"}', 2000, 20),
('Barber', 'Hair', 'PG Cut (13 & under)', '{"Cut and style", "Steamed Towel"}', 2500, 25),
('Barber', 'Hair', 'Hair of the Dog', '{"In between cut clean up", "(neck, around ears, temples and sideburns)", "Precision edge up with straight razor"}', 1000, 10),
('Barber', 'Coloring', 'Camouflage', '{"Remove years with out grey camouflage coloring", "Blends Grey while leaving natural look"}', 3500, 35),
('Barber', 'Coloring', 'Full Color', '{"Prices vary based on process, amount of hair etc.", "Full coverage color"}', 6000, 60),
('Barber', 'Beard', 'Spruce Beard Trim', '{"Personal consultation", "Beard Shape, Trim", "Beard Conditioning Mask", "Steamed Towel", "Precision edge up with straight razor"}', 2400, 24),
('Barber', 'Beard', 'Basic Beard Trim', '{"Personal consultation", "Beard Shape, Trim", "Precision neck shave with trimmers"}', 1200, 12),
('Barber', 'Beard', 'Beard Mask/Blow Out', '{"Steamed Towel", "Beard conditioning treatment mask (Olaplex)", "Beard blow out"}', 1500, 15),
('Barber', 'Shave', 'Spruce Shave', '{"Steamed Towel", "Beard conditioning treatment mask (Olaplex)", "Beard blow out"}', 5000, 60),
('Barber', 'Shave', 'Head Shave', '{"Personal consultation", "Pre Shave Lather", "Series of Steamed Towels", "Precision Full Head, Neck shave with straight razor", "Refreshing Shampoo", "Energizing Cold Towel", "After Shave Treatment"}', 3500, 35),
('Barber', 'Shave', 'Basic Shave', '{"Steamed Towel", "Pre Shave Lather", "Classic Shave with straight razor that goes with the grain", "After Shave Treatment"}', 3500, 35),
('Barber', 'Additional', 'Back Chest Wax', '{"Pre epilation", "Wax back or chest", "Post epilation", "Price varies on amount of hair removed"}', 1500, 15),
('Barber', 'Additional', 'Man Wax', '{"Pre epilation", "Wax of ears, nose, eye brows", "Shaping of eye brows", "Post epilation"}', 1200, 15),
('Barber', 'Additional', 'Basic Wax', '{"Pre epilation", "Wax/Shape Eye Brow", "Post epilation"}', 500, 10),
('Barber', 'Additional', 'Black Mask', '{" Removes dirt, black heads and impurities, absorbs excess oil and reveals a healthy, glowing complexion.", "Steamed Towel", "Application of Black Mask", "Removal of Black Mask"}', 1000, 10),
('Barber', 'Additional', '24k Gold Mask', '{"Instantly imporves the appearance of fine lines and wrinkles with caffeine, collagen, and gold for a youtful-looking complexion.", "Steamed Towel", "Application of 24k Gold Mask", "Removal of 24k Gold Mask"}', 1500, 15),
('Barber', 'Additional', 'Ear Candling', '{"Ear candeling is a practice in which a hollow candle is inserted into the external auditory canal and lit, with the patient lying on the opposite ear the combination of heat and suction removes earwax.", "Application and Removal of Candle in each ear."}', 1500, 15);

INSERT INTO users(first_name, last_name, email, phone_number, pictureUrl, owner, staff, customer)
VALUES
('Brooke','Bellenger','brooke@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Patrick','Bullion','patrick@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Mallory','Petry','mallory@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Michelle','Vincent','michelle@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Jonathan','Meier','jonathan@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Oscar','Mirand','oscar@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Hogan','Alcorn','hogan@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Mark','Twaddell','mark@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Doug','Sartin','doug@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Jason','Vrendenburg','jason@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Jake','Smith','jake@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Eddie','Capistran','eddie@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, true, false),
('Customer','User','customer@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false, false, true),
('Owner','User','owner@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', true,  false, false),
('Oscar','Miranda','testing@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false,  false, true),
('Jonathan','Meier','anotheremail@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false,  false, true),
('Doug','Sartin','douglas@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false,  false, true),
('Dustin','Williams','doover@gmail.com','4093443814', 'https://lh3.googleusercontent.com/-5iIqTS4qU_o/AAAAAAAAAAI/AAAAAAAAAIw/UugE0cC2NHI/photo.jpg', false,  false, true);
