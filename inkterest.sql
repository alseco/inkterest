DROP DATABASE if EXISTS inkterest;
CREATE database inkterest;
USE inkterest;

CREATE table topic(
	topic_name varchar(30) not null, 
	CONSTRAINT topic_topic_name_pk PRIMARY KEY(topic_name)
);

CREATE table user(
	email text not null,
	username varchar(20) not null,
	password text not null, 
	following_count int(5) not null, 
	follower_count int(5) not null,
	likes int DEFAULT 0,
	CONSTRAINT user_username_pk PRIMARY KEY(username)
);

CREATE table board(
	board_name varchar(20) not null,
	username varchar(20) not null,
	CONSTRAINT board_username_fk FOREIGN KEY(username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT board_board_name_pk PRIMARY KEY(board_name)
);

CREATE table topic_post(
	topic_post_id int(5) not null AUTO_INCREMENT,
	topic_name varchar(30) not null,
	post text not null,
	CONSTRAINT topic_post_topic_name_fk FOREIGN KEY(topic_name) REFERENCES topic(topic_name),
	CONSTRAINT topic_post_topic_post_id_pk PRIMARY KEY(topic_post_id)
);

CREATE table pin(
	pin_id int(5) not null AUTO_INCREMENT,
	content text not null,
	time_of_post timestamp not null,
	username varchar(20) not null,
	board_name varchar(20) not null,
	topic_name varchar(30) not null,
	likes int DEFAULT 0,
	CONSTRAINT pin_username_fk FOREIGN KEY(username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT pin_board_name_fk FOREIGN KEY(board_name) REFERENCES board(board_name),
	CONSTRAINT pin_topic_name_fk FOREIGN KEY(topic_name) REFERENCES topic(topic_name),
	CONSTRAINT pin_pin_id_pk PRIMARY KEY(pin_id)
);

create table boardfollowers(
	board_name varchar(20) not null,
	follower_username varchar(20) not null,
	following_username varchar(20) not null,
	CONSTRAINT boardfollowers_board_name_fk FOREIGN KEY(board_name) REFERENCES board(board_name),
	CONSTRAINT boardfollowers_follower_username_fk FOREIGN KEY(follower_username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT boardfollowers_following_username_fk FOREIGN KEY(following_username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE
);

create table userfollowers(
	follower_username varchar(20) not null,
	following_username varchar(20) not null,
	CONSTRAINT userfollowers_follower_username_fk FOREIGN KEY(follower_username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT userfollowers_following_username_fk FOREIGN KEY(following_username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into topic values('Music');
insert into topic values('Art');
insert into topic values('Sports');
insert into topic values('Fashion');
insert into topic values('Science');
insert into topic values('General Info');
insert into topic values('Religion');
insert into topic values('Food');
insert into topic values('Places');

insert into user values('jerico@gmail.com', 'jericorny', 'hahaha', 0, 0,0);
insert into user values('aya@gmail.com', 'ayabells', 'hehehe', 0, 0,0);
insert into user values('alyssa@gmail.com', 'sasasmile', 'hihihi', 0, 0,0);
insert into user values('sam@gmail.com', 'samsamsam', 'hohoho', 0, 0,0);
insert into user values('zoe@gmail.com', 'zoeeeee', 'huhuhu', 0, 0,0);
insert into user values('uplb@gmail.com', 'uplb', 'uplb', 0, 0,0);
insert into user values('bscs@gmail.com', 'bscs', 'bscs', 0, 0,0);

insert into userfollowers values('jericorny', 'ayabells');
insert into userfollowers values('ayabells', 'jericorny');
insert into userfollowers values('samsamsam', 'zoeeeee');
insert into userfollowers values('zoeeeee', 'samsamsam');
insert into userfollowers values('sasasmile', 'ayabells');
insert into userfollowers values('sasasmile', 'jericorny');
insert into userfollowers values('sasasmile', 'zoeeeee');
insert into userfollowers values('sasasmile', 'samsamsam');
insert into userfollowers values('zoeeeee', 'uplb');
insert into userfollowers values('uplb', 'ayabells');
insert into userfollowers values('samsamsam', 'jericorny');
insert into userfollowers values('ayabells', 'zoeeeee');
insert into userfollowers values('bscs', 'samsamsam');
insert into userfollowers values('jericorny', 'zoeeeee');
insert into userfollowers values('jericorny', 'samsamsam');

insert into board values('CMSC 165', 'jericorny');
insert into board values('RelationshipGoals', 'jericorny');
insert into board values('Food!', 'ayabells');
insert into board values('UPLB', 'sasasmile');
insert into board values('WebDev', 'samsamsam');
insert into board values('OOTD', 'zoeeeee');
insert into board values('uplbboard', 'uplb');
insert into board values('bscsboard', 'bscs');


insert into pin values(pin_id, 'Augmented reality (AR) is a live, 
	direct or indirect, view of a physical, real-world environment whose elements 
	are augmented by computer-generated sensory input.', now(), 'jericorny', 'CMSC 165', 'Art',0);

insert into pin values(pin_id, 'Chroma key compositing, or chroma keying, is a 
	special effects/post-production technique for compositing (layering) two images
	 or video streams together based on color hues (chroma range).', now(), 'jericorny', 'CMSC 165', 'Art', 0);

insert into pin values(pin_id, 'Pizzapop is the best pizza store in UPLB :)', now(), 'ayabells', 'Food!', 'Food', 0);
insert into pin values(pin_id, 'Few things are more disappointing than finding what seems like the perfect recipe 
	only to click and learn that it has more than 20 ingredients, 
	several of which you’ve never heard of', now(), 'ayabells', 'Food!', 'Food', 0);	

insert into pin values(pin_id, 'I wanted to take MassComm in UP Diliman but my UPCAT grade brought me to UP Los Baños
 where I took my degree in Communication Arts major in Speech Communication. ', now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'This is also the first time that my boyfriend will be seeing the place where I stayed for 4 years. 
	So I felt like a tour guide but obviously, I was more excited than the "tourist".', now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'First Stop - Lunch at International Rice Research Institute (IRRI)', 
 now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'Creating software isn’t that easy. There a ton of things to consider. 
	The more you actually create, the more you’ll learn.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Especially for front-end developers, the blog is definitely a great source for staying up-to-date.', 
 now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'With top-tier fashion bloggers raking in multimillion-dollar campaigns, it’s no wonder every self-proclaimed fashionista 
	wants to launch a personal style site.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'DailyJS is a great blog when it comes to JavaScript frameworks. It publishes great news articles, 
	tips, and resources on a variety of JavaScript frameworks and modules.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Not every fashion blogger is a 20-something female with an unhealthy obsession for Mansur Gavriel. In fact, the newest crop of 
	blogging sensations are selfie-obsessed dapper dandies, following in the footsteps of industry trailblazers like 
	Bryanboy.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'First Stop - Lunch at International Rice Research Institute (IRRI)', 
 now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'Creating software isn’t that easy. There a ton of things to consider. 
	The more you actually create, the more you’ll learn.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Especially for front-end developers, the blog is definitely a great source for staying up-to-date.', 
 now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'With top-tier fashion bloggers raking in multimillion-dollar campaigns, it’s no wonder every self-proclaimed fashionista 
	wants to launch a personal style site.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'DailyJS is a great blog when it comes to JavaScript frameworks. It publishes great news articles, 
	tips, and resources on a variety of JavaScript frameworks and modules.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Not every fashion blogger is a 20-something female with an unhealthy obsession for Mansur Gavriel. In fact, the newest crop of 
	blogging sensations are selfie-obsessed dapper dandies, following in the footsteps of industry trailblazers like 
	Bryanboy.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'A great blog worth mentioning is the personal blog from Stoyan Stefanov, who’s a Facebook engineer and the author of some 
	really great books!', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Augmented reality (AR) is a live, 
	direct or indirect, view of a physical, real-world environment whose elements 
	are augmented by computer-generated sensory input.', now(), 'jericorny', 'CMSC 165', 'Art',0);

insert into pin values(pin_id, 'A great blog worth mentioning is the personal blog from Stoyan Stefanov, who’s a Facebook engineer and the author of some 
	really great books!', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Augmented reality (AR) is a live, 
	direct or indirect, view of a physical, real-world environment whose elements 
	are augmented by computer-generated sensory input.', now(), 'jericorny', 'CMSC 165', 'Art',0);

insert into pin values(pin_id, 'Chroma key compositing, or chroma keying, is a 
	special effects/post-production technique for compositing (layering) two images
	 or video streams together based on color hues (chroma range).', now(), 'jericorny', 'CMSC 165', 'Art', 0);

insert into pin values(pin_id, 'Pizzapop is the best pizza store in UPLB :)', now(), 'ayabells', 'Food!', 'Food', 0);
insert into pin values(pin_id, 'Few things are more disappointing than finding what seems like the perfect recipe 
	only to click and learn that it has more than 20 ingredients, 
	several of which you’ve never heard of', now(), 'ayabells', 'Food!', 'Food', 0);	

insert into pin values(pin_id, 'I wanted to take MassComm in UP Diliman but my UPCAT grade brought me to UP Los Baños
 where I took my degree in Communication Arts major in Speech Communication. ', now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'This is also the first time that my boyfriend will be seeing the place where I stayed for 4 years. 
	So I felt like a tour guide but obviously, I was more excited than the "tourist".', now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'First Stop - Lunch at International Rice Research Institute (IRRI)', 
 now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'Creating software isn’t that easy. There a ton of things to consider. 
	The more you actually create, the more you’ll learn.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Especially for front-end developers, the blog is definitely a great source for staying up-to-date.', 
 now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'With top-tier fashion bloggers raking in multimillion-dollar campaigns, it’s no wonder every self-proclaimed fashionista 
	wants to launch a personal style site.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'DailyJS is a great blog when it comes to JavaScript frameworks. It publishes great news articles, 
	tips, and resources on a variety of JavaScript frameworks and modules.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Not every fashion blogger is a 20-something female with an unhealthy obsession for Mansur Gavriel. In fact, the newest crop of 
	blogging sensations are selfie-obsessed dapper dandies, following in the footsteps of industry trailblazers like 
	Bryanboy.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'A great blog worth mentioning is the personal blog from Stoyan Stefanov, who’s a Facebook engineer and the author of some 
	really great books!', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Augmented reality (AR) is a live, 
	direct or indirect, view of a physical, real-world environment whose elements 
	are augmented by computer-generated sensory input.', now(), 'jericorny', 'CMSC 165', 'Art',0);

insert into pin values(pin_id, 'Chroma key compositing, or chroma keying, is a 
	special effects/post-production technique for compositing (layering) two images
	 or video streams together based on color hues (chroma range).', now(), 'jericorny', 'CMSC 165', 'Art', 0);

insert into pin values(pin_id, 'Pizzapop is the best pizza store in UPLB :)', now(), 'ayabells', 'Food!', 'Food', 0);
insert into pin values(pin_id, 'Few things are more disappointing than finding what seems like the perfect recipe 
	only to click and learn that it has more than 20 ingredients, 
	several of which you’ve never heard of', now(), 'ayabells', 'Food!', 'Food', 0);	

insert into pin values(pin_id, 'I wanted to take MassComm in UP Diliman but my UPCAT grade brought me to UP Los Baños
 where I took my degree in Communication Arts major in Speech Communication. ', now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'First Stop - Lunch at International Rice Research Institute (IRRI)', 
 now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'Creating software isn’t that easy. There a ton of things to consider. 
	The more you actually create, the more you’ll learn.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Especially for front-end developers, the blog is definitely a great source for staying up-to-date.', 
 now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'With top-tier fashion bloggers raking in multimillion-dollar campaigns, it’s no wonder every self-proclaimed fashionista 
	wants to launch a personal style site.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'DailyJS is a great blog when it comes to JavaScript frameworks. It publishes great news articles, 
	tips, and resources on a variety of JavaScript frameworks and modules.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Not every fashion blogger is a 20-something female with an unhealthy obsession for Mansur Gavriel. In fact, the newest crop of 
	blogging sensations are selfie-obsessed dapper dandies, following in the footsteps of industry trailblazers like 
	Bryanboy.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'A great blog worth mentioning is the personal blog from Stoyan Stefanov, who’s a Facebook engineer and the author of some 
	really great books!', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Augmented reality (AR) is a live, 
	direct or indirect, view of a physical, real-world environment whose elements 
	are augmented by computer-generated sensory input.', now(), 'jericorny', 'CMSC 165', 'Art',0);

insert into pin values(pin_id, 'This is also the first time that my boyfriend will be seeing the place where I stayed for 4 years. 
	So I felt like a tour guide but obviously, I was more excited than the "tourist".', now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'First Stop - Lunch at International Rice Research Institute (IRRI)', 
 now(), 'sasasmile', 'UPLB', 'Places', 0);

insert into pin values(pin_id, 'Creating software isn’t that easy. There a ton of things to consider. 
	The more you actually create, the more you’ll learn.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Especially for front-end developers, the blog is definitely a great source for staying up-to-date.', 
 now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'With top-tier fashion bloggers raking in multimillion-dollar campaigns, it’s no wonder every self-proclaimed fashionista 
	wants to launch a personal style site.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'DailyJS is a great blog when it comes to JavaScript frameworks. It publishes great news articles, 
	tips, and resources on a variety of JavaScript frameworks and modules.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Not every fashion blogger is a 20-something female with an unhealthy obsession for Mansur Gavriel. In fact, the newest crop of 
	blogging sensations are selfie-obsessed dapper dandies, following in the footsteps of industry trailblazers like 
	Bryanboy.', now(), 'zoeeeee', 'OOTD', 'Fashion', 0);

insert into pin values(pin_id, 'A great blog worth mentioning is the personal blog from Stoyan Stefanov, who’s a Facebook engineer and the author of some 
	really great books!', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'With top-tier fashion bloggers raking in multimillion-dollar campaigns, it’s no wonder every self-proclaimed fashionista 
	wants to launch a personal style site.', now(), 'uplb', 'uplbboard', 'Fashion', 0);

insert into pin values(pin_id, 'DailyJS is a great blog when it comes to JavaScript frameworks. It publishes great news articles, 
	tips, and resources on a variety of JavaScript frameworks and modules.', now(), 'uplb', 'uplbboard', 'Science', 0);

insert into pin values(pin_id, 'Not every fashion blogger is a 20-something female with an unhealthy obsession for Mansur Gavriel. In fact, the newest crop of 
	blogging sensations are selfie-obsessed dapper dandies, following in the footsteps of industry trailblazers like 
	Bryanboy.', now(), 'uplb', 'uplbboard', 'Fashion', 0);

insert into pin values(pin_id, 'A great blog worth mentioning is the personal blog from Stoyan Stefanov, who’s a Facebook engineer and the author of some 
	really great books!', now(), 'uplb', 'uplbboard', 'Science', 0);

insert into pin values(pin_id, 'This is also the first time that my boyfriend will be seeing the place where I stayed for 4 years. 
	So I felt like a tour guide but obviously, I was more excited than the "tourist".', now(), 'bscs', 'bscsboard', 'Places', 0);

insert into pin values(pin_id, 'First Stop - Lunch at International Rice Research Institute (IRRI)', 
 now(), 'bscs', 'bscsboard', 'Places', 0);

insert into pin values(pin_id, 'Creating software isn’t that easy. There a ton of things to consider. 
	The more you actually create, the more you’ll learn.', now(), 'samsamsam', 'WebDev', 'Science', 0);

insert into pin values(pin_id, 'Especially for front-end developers, the blog is definitely a great source for staying up-to-date.', 
 now(), 'bscs', 'bscsboard', 'Science', 0);

insert into pin values(pin_id, 'Creating software isn’t that easy. There a ton of things to consider. 
	The more you actually create, the more you’ll learn.', now(), 'jericorny', 'RelationshipGoals', 'Science', 0);

insert into pin values(pin_id, 'Especially for front-end developers, the blog is definitely a great source for staying up-to-date.', 
 now(), 'jericorny', 'RelationshipGoals', 'Science', 0);

insert into topic_post values(topic_post_id, 'Music', 'Instruments');
insert into topic_post values(topic_post_id, 'Music', 'My Heart Will Go On');
insert into topic_post values(topic_post_id, 'Music', 'Taylor Swift');
insert into topic_post values(topic_post_id, 'Music', 'Thats what people say');
insert into topic_post values(topic_post_id, 'Music', 'Highest note sung');

insert into topic_post values(topic_post_id, 'Art', 'Sculpture');
insert into topic_post values(topic_post_id, 'Art', 'Starry night');
insert into topic_post values(topic_post_id, 'Art', 'Fernando Amorsolo');
insert into topic_post values(topic_post_id, 'Art', 'Mona Lisa');
insert into topic_post values(topic_post_id, 'Art', 'Leonardo Da Vinci');

insert into topic_post values(topic_post_id, 'Sports', 'Golden State Warriors');
insert into topic_post values(topic_post_id, 'Sports', 'Stephen Curry');
insert into topic_post values(topic_post_id, 'Sports', 'FIBA Asia Cahmpionship');
insert into topic_post values(topic_post_id, 'Sports', 'FC Barcelona');
insert into topic_post values(topic_post_id, 'Sports', 'Super Bowl');

insert into topic_post values(topic_post_id, 'Fashion', 'Crop Top');
insert into topic_post values(topic_post_id, 'Fashion', 'Skinny Jeans');
insert into topic_post values(topic_post_id, 'Fashion', 'Jumper');
insert into topic_post values(topic_post_id, 'Fashion', 'Lady Gaga outfit');
insert into topic_post values(topic_post_id, 'Fashion', 'Off-shoulder');

insert into topic_post values(topic_post_id, 'Science', 'Environmental Science');
insert into topic_post values(topic_post_id, 'Science', 'Physics');
insert into topic_post values(topic_post_id, 'Science', 'Matter');
insert into topic_post values(topic_post_id, 'Science', 'Life cycle');
insert into topic_post values(topic_post_id, 'Science', 'Biology');

insert into topic_post values(topic_post_id, 'General info', 'Trump wins presidential election');
insert into topic_post values(topic_post_id, 'General info', 'Marcos burial');
insert into topic_post values(topic_post_id, 'General info', 'Planet Nibiru');
insert into topic_post values(topic_post_id, 'General info', 'Super typhoon haiyan');
insert into topic_post values(topic_post_id, 'General info', 'Toblerone changes shape');

insert into topic_post values(topic_post_id, 'Religion', 'Christianity');
insert into topic_post values(topic_post_id, 'Religion', 'John 3:16');
insert into topic_post values(topic_post_id, 'Religion', 'Muslim');
insert into topic_post values(topic_post_id, 'Religion', 'Buddhism');
insert into topic_post values(topic_post_id, 'Religion', 'Lead Me to the Cross');
