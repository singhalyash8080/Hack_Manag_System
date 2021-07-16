CREATE TABLE hackathon(
    hack_id VARCHAR(8),
    name VARCHAR(20),
    description VARCHAR(500),
    start_date DATE,
    end_date DATE,
    min_team_size NUMBER(1),
    max_team_size NUMBER(1),
    no_of_rounds NUMBER(1),
    CONSTRAINT PK_hackathon PRIMARY KEY(hack_id)
);

CREATE TABLE CENTRE(
    centre_id VARCHAR(4),
    name VARCHAR(20),
    street VARCHAR(20),
    city VARCHAR(20),
    state VARCHAR(20),
    pincode CHAR(7),
    hack_id VARCHAR(8),
    CONSTRAINT PK_centre_id PRIMARY KEY(centre_id),
    CONSTRAINT hack_FK FOREIGN KEY(hack_id) REFERENCES hackathon(hack_id) ON DELETE CASCADE
);

CREATE TABLE speaker(
    speaker_email VARCHAR(20),
    name VARCHAR(20),
    organization VARCHAR(20),
    description VARCHAR(100),
    phone_num CHAR(12),
    hack_id VARCHAR(8),
    CONSTRAINT PK_speaker PRIMARY KEY(speaker_email),
    CONSTRAINT hack_FK2 FOREIGN KEY(hack_id) REFERENCES hackathon(hack_id) ON DELETE CASCADE,
    CONSTRAINT chk_phone CHECK (LENGTH(phone_num)=12)
);

CREATE TABLE organizer(
    organizer_email VARCHAR(20),
    name VARCHAR(20),
    info VARCHAR(100),
    phone_num CHAR(12),
    hack_id VARCHAR(8),
    centre_id VARCHAR(4),
    CONSTRAINT PK_organizer PRIMARY KEY(organizer_email),
    CONSTRAINT hack_FK3 FOREIGN KEY(hack_id) REFERENCES hackathon(hack_id) ON DELETE SET NULL,
    CONSTRAINT centre_FK FOREIGN KEY(centre_id) REFERENCES centre(centre_id) ON DELETE SET NULL,
    CONSTRAINT chk_phone2 CHECK (LENGTH(phone_num)=12)
);

CREATE TABLE allocates_speaker(
    organizer_email VARCHAR(20),
    speaker_email VARCHAR(20),
    CONSTRAINT PK_allocates_speaker PRIMARY KEY(organizer_email,speaker_email),
    CONSTRAINT org_FK FOREIGN KEY(organizer_email) REFERENCES organizer(organizer_email) ON DELETE CASCADE,
    CONSTRAINT speaker_FK FOREIGN KEY(speaker_email) REFERENCES speaker(speaker_email) ON DELETE CASCADE
);

CREATE TABLE judge(
    judge_email VARCHAR(20),
    name VARCHAR(20),
    profession VARCHAR(20),
    about VARCHAR(100),
    phone_num CHAR(12),
    hack_id VARCHAR(8),
    CONSTRAINT PK_judge PRIMARY KEY(judge_email),
    CONSTRAINT hack_FK4 FOREIGN KEY(hack_id) REFERENCES hackathon(hack_id) ON DELETE CASCADE
);

CREATE TABLE allocates_judge(
    organizer_email VARCHAR(20),
    judge_email VARCHAR(20),
    CONSTRAINT PK_allocates_judge PRIMARY KEY(organizer_email,judge_email),
    CONSTRAINT org_FK2 FOREIGN KEY(organizer_email) REFERENCES organizer(organizer_email) ON DELETE CASCADE,
    CONSTRAINT judge_FK FOREIGN KEY(judge_email) REFERENCES judge(judge_email) ON DELETE CASCADE
);

CREATE TABLE sponsor(
    sponsor_email VARCHAR(20),
    name VARCHAR(20),
    description VARCHAR(100),
    hack_id VARCHAR(8),
    CONSTRAINT PK_sponsor PRIMARY KEY(sponsor_email),
    CONSTRAINT hack_FK5 FOREIGN KEY(hack_id) REFERENCES hackathon(hack_id) ON DELETE CASCADE
);

CREATE TABLE allocates_sponsor(
    organizer_email VARCHAR(20),
    sponsor_email VARCHAR(20),
    CONSTRAINT PK_allocates_sponsor PRIMARY KEY(organizer_email,sponsor_email),
    CONSTRAINT org_FK3 FOREIGN KEY(organizer_email) REFERENCES organizer(organizer_email) ON DELETE CASCADE,
    CONSTRAINT sponsor_FK2 FOREIGN KEY(sponsor_email) REFERENCES sponsor(sponsor_email) ON DELETE CASCADE
);

CREATE TABLE prize(
    prize_id VARCHAR(8),
    prize_name VARCHAR(20),
    prize_description VARCHAR(300),
    sponsor_email VARCHAR(20),
    CONSTRAINT PK_prize PRIMARY KEY(prize_id),
    CONSTRAINT sponsor_FK FOREIGN KEY(sponsor_email) REFERENCES sponsor(sponsor_email) ON DELETE CASCADE
);

CREATE TABLE team(
    team_id VARCHAR(8),
    name VARCHAR(20),
    num_of_members NUMBER(1),
    project_name VARCHAR(20),
    project_description VARCHAR(100),
    project_github_link VARCHAR(20),
    CONSTRAINT PK_team PRIMARY KEY(team_id)
);

CREATE TABLE prize_to(
    prize_id VARCHAR(8),
    team_id VARCHAR(8),
    CONSTRAINT PK_prize_to PRIMARY KEY(prize_id,team_id),
    CONSTRAINT prize_FK FOREIGN KEY(prize_id) REFERENCES prize(prize_id) ON DELETE CASCADE,
    CONSTRAINT team_FK2 FOREIGN KEY(team_id) REFERENCES team(team_id) ON DELETE CASCADE
);

CREATE TABLE takes_part_in(
    team_id VARCHAR(8),
    hack_id VARCHAR(8),
    CONSTRAINT PK_takes_part_in PRIMARY KEY(team_id,hack_id),
    CONSTRAINT team_FK FOREIGN KEY(team_id) REFERENCES team(team_id) ON DELETE CASCADE,
    CONSTRAINT hack_FK6 FOREIGN KEY(hack_id) REFERENCES hackathon(hack_id) ON DELETE CASCADE
);


CREATE TABLE judges_team(
    judge_email VARCHAR(20),
    team_id VARCHAR(8),
    CONSTRAINT PK_judges_team PRIMARY KEY(judge_email,team_id),
    CONSTRAINT judge_FK2 FOREIGN KEY(judge_email) REFERENCES judge(judge_email) ON DELETE CASCADE,
    CONSTRAINT team_FK3 FOREIGN KEY(team_id) REFERENCES team(team_id) ON DELETE CASCADE
);

CREATE TABLE participant(
    user_email VARCHAR(20),
    name VARCHAR(20),
    college_name VARCHAR(20),
    domain VARCHAR(20),
    phone_num CHAR(12),
    CONSTRAINT PK_user PRIMARY KEY(user_email)
);

CREATE TABLE part_of(
    user_email VARCHAR(20),
    team_id VARCHAR(8),
    CONSTRAINT PK_part_of PRIMARY KEY(user_email,team_id),
    CONSTRAINT team_FK4 FOREIGN KEY(team_id) REFERENCES team(team_id) ON DELETE CASCADE,
	CONSTRAINT FK_user FOREIGN KEY(user_email) REFERENCES participant(user_email) ON DELETE CASCADE
);

-- ALTER TABLE part_of add constraint FK_user FOREIGN KEY(user_email) REFERENCES participant(user_email) ON DELETE CASCADE;

INSERT INTO hackathon VALUES (
	'1111AAAA',
	'Equinox 2021',
	'Equinox aims to provide 36 uninterrupted hours of ideation and innovation. Hackers will receive a platform with the necessary resources to put forth their ideas and skills. In Equinox, imagination is not limited by specific problem statements, In addition to it hackers are given the intellectual freedom to obliterate the boundaries of their imaginative power and tap into their creativity to come up with unique solutions to the problems, they see fit.',
	TO_DATE('2021-06-25','YYYY-MM-DD'),
	TO_DATE('2021-06-27','YYYY-MM-DD'),
	1,
	4,
	3
);

INSERT INTO hackathon VALUES (
	'2222BBBB',
	'Citython Eindhoven',
	'This online Citython edition will be held in the city of Eindhoven, The Netherlands, and is focused on mobility optimization, traffic safety areas and a healthy city future. The goal of this Citython is that young professionals search for innovative and creative solutions that can be applied in the city of Eindhoven to foster innovation.',
	TO_DATE('2021-07-2','YYYY-MM-DD'),
	TO_DATE('2021-07-3','YYYY-MM-DD'),
	1,
	3,
	2
);

INSERT INTO hackathon VALUES (
	'3333CCCC',
	'AI Fair',
	'AI Community is seeking projects across the world, designed and developed by high and middle school students. These projects should try to solve problems related to community or the environment and use technology or AI to solve the problems. The fair is open to all high and middle school students who will solve a community or environment focused problem using technology. Top projects will be showcased on the website and also recognized with awards, scholarships/prizes, and mentorship',
	TO_DATE('2021-06-5','YYYY-MM-DD'),
	TO_DATE('2021-06-9','YYYY-MM-DD'),
	3,
	5,
	4
);

-- ________________________________________________________________________________________________________

INSERT INTO centre VALUES(
	'11AA',
	'Anna Auditorium',
	'VIT',
	'Vellore',
	'Tamil Nadu',
	632014,
	'1111AAAA'
);

INSERT INTO centre VALUES(
	'22BB',
	'ST. George College',
	'Nehru Enclave',
	'Agra',
	'Uttar Pradesh',
	282001,
	'2222BBBB'
);

INSERT INTO centre VALUES(
	'33CC',
	'Computer Centre',
	'IIIT Delhi',
	'Delhi',
	'Delhi',
	110020,
	'3333CCCC'
);

-- ________________________________________________________________________________________________________

INSERT INTO speaker VALUES(
	'umang.s@vit.ac.in',
	'Umang Singh',
	'VITLUG, VIT',
	'Project Head of VIT Linux User Group, begin a startup in 2nd year',
	'911234567891',
	'1111AAAA'
);

INSERT INTO speaker VALUES(
	'pravesh@ms.co.in',
	'Pravesh Sharma',
	'Microsoft India',
	'Senior Developer at Microsoft, India. Currently working on WSL. Previously worled on Visual Studio',
	'911234567892',
	'2222BBBB'
);

INSERT INTO speaker VALUES(
	'abhi.nav@openAI.us',
	'Abhinav Dubey',
	'Open AI',
	'Top Researcher at OpenAI, the world leading AI Company. Currently Working GPT3',
	'911234567893',
	'3333CCCC'
);

-- ________________________________________________________________________________________________________

INSERT INTO organizer VALUES(
	'ayush.dwi@vit.ac.in',
	'Ayush Dwivedi',
	'A member of Management team and a core part of it',
	'911234567894',
	'1111AAAA',
	'11AA'
);

INSERT INTO organizer VALUES(
	'yash.s@gmail.com',
	'Yash Singh',
	'A member of Student welfare community at Agra College',
	'911234567895',
	'2222BBBB',
	'33CC'
);

INSERT INTO organizer VALUES(
	'hvon@outlook.com',
	'Harvey Glockner',
	'President of DSC Management team at IIIT Delhi',
	'911234567896',
	'3333CCCC',
	'33CC'
);

-- ________________________________________________________________________________________________________

INSERT INTO allocates_speaker VALUES(
	'ayush.dwi@vit.ac.in',
	'umang.s@vit.ac.in'
);

INSERT INTO allocates_speaker VALUES(
	'yash.s@gmail.com',
	'pravesh@ms.co.in'
);

INSERT INTO allocates_speaker VALUES(
	'hvon@outlook.com',
	'abhi.nav@openAI.us'
);

-- ________________________________________________________________________________________________________

INSERT INTO judge VALUES(
	'judge1@gamil.com',
	'Satyam Pachaoury',
	'Senior Developer',
	'Performs various development duties, and with specialization as web development',
	'911234567897',
	'1111AAAA'
);

INSERT INTO judge VALUES(
	'judge2@gamil.com',
	'Pratham Sharma',
	'Project Manager',
	'Manages various project duties at Microsoft, India',
	'911234567898',
	'2222BBBB'
);

INSERT INTO judge VALUES(
	'judge3@gamil.com',
	'Pratham Jha',
	'AI Developer',
	'A very reputed person in AI community',
	'911234567899',
	'3333CCCC'
);

-- ________________________________________________________________________________________________________

INSERT INTO allocates_judge VALUES(
	'ayush.dwi@vit.ac.in',
	'judge1@gamil.com'
);
INSERT INTO allocates_judge VALUES(
	'yash.s@gmail.com',
	'judge2@gamil.com'
);
INSERT INTO allocates_judge VALUES(
	'hvon@outlook.com',
	'judge3@gamil.com'
);

-- ________________________________________________________________________________________________________

INSERT INTO sponsor VALUES(
	'sponsor1@gmail.com',
	'Linode',
	'Linode is an American cloud hosting company that provides virtual private servers',
	'1111AAAA'
);
INSERT INTO sponsor VALUES(
	'sponsor2@gmail.com',
	'Microsoft',
	'Microsoft develops, manufactures, supports, and sells software, electronics, PCs, related services',
	'2222BBBB'
);
INSERT INTO sponsor VALUES(
	'sponsor3@gmail.com',
	'OpenAI',
	'OpenAI is research and deployment company with mission to ensure that AGI benefits all life',
	'3333CCCC'
);

-- ________________________________________________________________________________________________________

INSERT INTO allocates_sponsor VALUES(
	'ayush.dwi@vit.ac.in',
	'sponsor1@gmail.com'
);
INSERT INTO allocates_sponsor VALUES(
	'yash.s@gmail.com',
	'sponsor2@gmail.com'
);
INSERT INTO allocates_sponsor VALUES(
	'hvon@outlook.com',
	'sponsor3@gmail.com'
);

-- ________________________________________________________________________________________________________

INSERT INTO prize VALUES(
	'P0000001',
    '1st Prize',
    '$250 and Mentorship',
    'sponsor1@gmail.com'
);
INSERT INTO prize VALUES(
	'P0000002',
    '2nd Prize',
    '$150 and Mentorship',
    'sponsor1@gmail.com'
);
INSERT INTO prize VALUES(
	'P0000003',
    '3rd Prize',
    '$75 and Goodies',
    'sponsor1@gmail.com'
);

INSERT INTO prize VALUES(
	'P0000004',
    '1st Prize',
    'Microsoft GO Tab',
    'sponsor2@gmail.com'
);
INSERT INTO prize VALUES(
	'P0000005',
    '2nd Prize',
    'Azure 200 credits',
    'sponsor2@gmail.com'
);
INSERT INTO prize VALUES(
	'P0000006',
    '3rd Prize',
    'Azure 100 credits',
    'sponsor2@gmail.com'
);

INSERT INTO prize VALUES(
	'P0000007',
    '1st Prize',
    '$150 and Free Course',
    'sponsor3@gmail.com'
);
INSERT INTO prize VALUES(
	'P0000008',
    '2nd Prize',
    '$75 and Free Course',
    'sponsor3@gmail.com'
);
INSERT INTO prize VALUES(
	'P0000009',
    '3rd Prize',
    '$50 and Goodies',
    'sponsor3@gmail.com'
);

-- ________________________________________________________________________________________________________

INSERT INTO team VALUES(
	'T0000001',
    'Block Bandits',
    3,
    'TraceIt',
	'TraceIt aims to revolutionize Poultry Market using blockchain providing traceability and trust',
	'github.com/team1'
);
INSERT INTO team VALUES(
	'T0000002',
    'Team404',
    1,
    'Food Site',
	'A site where college students can subscribe for food service near college',
	'github.com/team2'
);
INSERT INTO team VALUES(
	'T0000003',
    'AI_Dreamers',
    4,
    'Best Map Route',
	'A ML based software that finds the best route on map with least travel time',
	'github.com/team3'
);

INSERT INTO team VALUES(
	'T0000004',
    'Noob squad',
    2,
    'Educator.ai',
	'A ML based software that finds the best teachers',
	'github.com/team4'
);

INSERT INTO team VALUES(
	'T0000005',
    'Error 404',
    2,
    'BitToInk',
	'A online pdf tool',
	'github.com/team5'
);

-- ________________________________________________________________________________________________________

INSERT INTO prize_to VALUES(
	'P0000001',
	'T0000001'
);
INSERT INTO prize_to VALUES(
	'P0000005',
	'T0000002'
);
INSERT INTO prize_to VALUES(
	'P0000009',
	'T0000003'
);

-- ________________________________________________________________________________________________________

INSERT INTO takes_part_in VALUES(
	'T0000001',
	'1111AAAA'
);
INSERT INTO takes_part_in VALUES(
	'T0000002',
	'2222BBBB'
);
INSERT INTO takes_part_in VALUES(
	'T0000003',
	'3333CCCC'
);

INSERT INTO takes_part_in VALUES(
	'T0000004',
	'1111AAAA'
);
INSERT INTO takes_part_in VALUES(
	'T0000005',
	'2222BBBB'
);

-- ________________________________________________________________________________________________________

INSERT INTO judges_team VALUES(
	'judge1@gamil.com',
	'T0000001'
);
INSERT INTO judges_team VALUES(
	'judge2@gamil.com',
	'T0000002'
);
INSERT INTO judges_team VALUES(
	'judge3@gamil.com',
	'T0000003'
);

-- ________________________________________________________________________________________________________

INSERT INTO participant VALUES(
	'user1.1@email.com',
    'Vaibhav',
    'VIT, Vellore',
    'Frontend Dev',
    911234567990
);
INSERT INTO participant VALUES(
	'user1.2@email.com',
    'Yash Singhal',
    'VIT, Vellore',
    'Frontend Dev',
    911234567990
);
INSERT INTO participant VALUES(
	'user1.3@email.com',
    'Ayush Dubey',
    'VIT, Vellore',
    'Frontend Dev',
    911234567990
);
INSERT INTO participant VALUES(
	'user2@email.com',
    'Ankit Sharma',
    'Agra College',
    'Blockchain Dev',
    911234567991
);
INSERT INTO participant VALUES(
	'user3.1@email.com',
    'Harsh',
    'IIIT Delhi',
    'Backend Dev',
    911234567992
);
INSERT INTO participant VALUES(
	'user3.2@email.com',
    'Om',
    'IIIT Delhi',
    'Backend Dev',
    911234567992
);
INSERT INTO participant VALUES(
	'user3.3@email.com',
    'Rahul',
    'IIIT Delhi',
    'Backend Dev',
    911234567992
);
INSERT INTO participant VALUES(
	'user3.4@email.com',
    'Shyam',
    'IIIT Delhi',
    'Backend Dev',
    911234567992
);

INSERT INTO participant VALUES(
    'user4@email.com',
    'Ravi',
    'Amity, Noida',
    'Backend Dev',
    911234567992
);
INSERT INTO participant VALUES(
    'user5@email.com',
    'Harsh',
    'Amity, Noida',
    'Backend Dev',
    911234567992
);

-- ________________________________________________________________________________________________________

INSERT INTO part_of VALUES(
	'user1.1@email.com',
	'T0000001'
);
INSERT INTO part_of VALUES(
	'user1.2@email.com',
	'T0000001'
);
INSERT INTO part_of VALUES(
	'user1.3@email.com',
	'T0000001'
);

INSERT INTO part_of VALUES(
	'user2@email.com',
	'T0000002'
);

INSERT INTO part_of VALUES(
	'user3.1@email.com',
	'T0000003'
);
INSERT INTO part_of VALUES(
	'user3.2@email.com',
	'T0000003'
);
INSERT INTO part_of VALUES(
	'user3.3@email.com',
	'T0000003'
);
INSERT INTO part_of VALUES(
	'user3.4@email.com',
	'T0000003'
);

INSERT INTO part_of VALUES(
	'user3.1@email.com',
	'T0000004'
);
INSERT INTO part_of VALUES(
	'user3.2@email.com',
	'T0000004'
);
INSERT INTO part_of VALUES(
	'user3.3@email.com',
	'T0000005'
);
INSERT INTO part_of VALUES(
	'user3.4@email.com',
	'T0000005'
);


drop TABLE part_of;
drop TABLE participant;
drop TABLE judges_team;
drop TABLE prize_to;
drop TABLE takes_part_in;
drop TABLE team;
drop TABLE allocates_sponsor;
drop TABLE prize;
drop TABLE sponsor;
drop TABLE allocates_judge;
drop TABLE judge;
drop TABLE allocates_speaker;
drop TABLE organizer;
drop TABLE speaker;
drop TABLE centre;
drop TABLE hackathon;


-- UPDATE participant set name = 'Ram' where user_email='user3.4@email.com'; 
-- UPDATE participant set name = 'Shyam' where user_email='user3.3@email.com'; 
-- UPDATE participant set name = 'Om' where user_email='user3.2@email.com'; 
-- UPDATE participant set name = 'Anshul' where user_email='user1.3@email.com'; 

--retrieve hack details from a particular duration
SELECT * FROM hackathon WHERE (start_date >= TO_DATE('2021-06-20','YYYY-MM-DD')) and (end_date <= TO_DATE('2021-06-30','YYYY-MM-DD')) order by name desc;

-- retrieve participant profile
SELECT user_email,name,nvl(college_name,'Not Provided') as college_name,domain,phone_num FROM participant WHERE user_email = 'user2@email.com';

COALESCE(NULLIF(cook.address,to_char(NULL)),'Unknown')

-- Retrieve organizer profile
select * from organizer where organizer_email='yash.s@gmail.com';

-- Retrieve team details
select team_id,name,num_of_members,project_name,COALESCE(NULLIF(project_description,to_char(NULL)),'Unknown') as project_description,project_github_link from team where team_id='T0000004';

-- Retrieve names of judges,speakers and sponsors for a particular hackathon
select name as names from sponsor where hack_id='1111AAAA' UNION (select name from judge where hack_id='1111AAAA' UNION select name from speaker where hack_id='1111AAAA');

-- Retrieve all teams for a particular hack (uncorrelated)
select * from team where team_id in (Select team_id from takes_part_in where hack_id = '1111AAAA');

-- Retrieving list of users who are part of a team
select * from participant where user_email in (select user_email from part_of where part_of.user_email = participant.user_email) order by name desc;

select hackathon.hack_id FROM hackathon LEFT JOIN takes_part_in ON hackathon.hack_id = takes_part_in.hack_id GROUP BY hackathon.hack_id HAVING count(takes_part_in.team_id) = 1;

Select participant.name,NVL(team.team_id,'no team') as team_id from participant FULL OUTER JOIN part_of ON participant.user_email = part_of.user_email FULL OUTER JOIN team ON team.team_id = part_of.team_id;

-- delete participant 
delete from participant where user_email in (Select user_email from participant where user_email='user3.3@email.com');

-- delete team
delete from team where team_id in (Select team_id from team where team_id='T0000001');

-- delete organizer
delete from organizer where organizer_email in (Select organizer_email from organizer where organizer_email='hvon@outlook.com');

-- delete hacks having no. of team = 1 (correlated)
delete from hackathon where hack_id in (select
    hackathon.hack_id
FROM
    hackathon
LEFT JOIN 
    takes_part_in ON hackathon.hack_id = takes_part_in.hack_id 
GROUP BY
    hackathon.hack_id
HAVING 
    count(takes_part_in.team_id) = 1);

-- Update description of every hack to “To be announced ” if the description is null. (NVL())
UPDATE hackathon SET description = NVL(description,'To Be Announced.') where hack_id in (Select hack_id from hackathon);

-- update team names to "no name "of teams having same name 
Update team set name='no name 2' where team_id in (Select t1.team_id from team t1 INNER JOIN team t2 ON t1.team_id!=t2.team_id where COALESCE(NULLIF(t1.name,t2.name),'yes')='yes');

-- update participant details
Update participant set college_name='harvard',domain='AI',phone_num='919645238172' where user_email in (Select user_email from participant where user_email='user3.4@email.com');

-- update details of hackathon
Update hackathon set name='AI fair 2.0',min_team_size=4 where hack_id in (Select hack_id from hackathon where hack_id='3333CCCC'); 



-- retrieve name of hackathon with max duration
CREATE OR REPLACE FUNCTION hack_with_max_dur
RETURN VARCHAR
IS
	cursor c_hack is SELECT name,start_date,end_date from hackathon;

	hack_rec c_hack%ROWTYPE;

	max_d NUMBER := 0;
	hack_name VARCHAR(20):= 'none';

BEGIN

	open c_hack;

	fetch c_hack into hack_rec;


	while(c_hack%found) loop

		if (hack_rec.end_date-hack_rec.start_date)>max_d THEN

			max_d := hack_rec.end_date-hack_rec.start_date;
			hack_name := hack_rec.name;
		END IF;

		fetch c_hack into hack_rec;

	end loop;

	close c_hack;

	return hack_name;
END;
/

BEGIN 
   dbms_output.put_line(hack_with_max_dur()); 
END;
/

BEGIN 
   dbms_output.put_line(()); 
END;
/

-- to retrieve names of the winning team of a particular hack
CREATE OR REPLACE PROCEDURE winners(hid VARCHAR)
	IS
	-- Declaring cursor
	CURSOR c_takes_part IS 
		SELECT takes_part_in.hack_id, prize_to.prize_id, prize_to.team_id 
		FROM takes_part_in INNER JOIN prize_to ON takes_part_in.team_id=prize_to.team_id WHERE hack_id=hid;
	v_takes_part c_takes_part%ROWTYPE;
	v_team_id team.team_id%TYPE;
	v_name team.name%TYPE;
BEGIN
	OPEN c_takes_part;
	FETCH c_takes_part INTO v_takes_part;
	WHILE(c_takes_part%FOUND) LOOP
		
		v_team_id := v_takes_part.team_id;
		SELECT team.name INTO v_name FROM team WHERE team.team_id=v_team_id;
		dbms_output.put_line('Winner of ' || hid || ': '|| v_name);

		FETCH c_takes_part INTO v_takes_part;
	END LOOP;
	CLOSE c_takes_part;
END;
/

begin
	winners('2222BBBB');
end;
/


-- delete team that violates the requirements of no. of participants in a team for a particular hack
CREATE OR REPLACE PROCEDURE delete_team(
    hackathon_id IN VARCHAR )
IS
	cursor c_takes_part is select * from takes_part_in where hack_id=hackathon_id;

	takes_part_rec c_takes_part%ROWTYPE; 

	team_rec team%ROWTYPE;

	team_id team.team_id%type;

	min_participants NUMBER := 0;
	max_participants NUMBER := 0;

BEGIN

	open c_takes_part;

	fetch c_takes_part into takes_part_rec;

	Select min_team_size,max_team_size INTO min_participants, max_participants from hackathon where hack_id=hackathon_id; 


	while(c_takes_part%found) loop

		team_id := takes_part_rec.team_id;

		delete from team where team.team_id=team_id and (team.num_of_members<min_participants or team.num_of_members>max_participants);
		dbms_output.put_line('team deleted');

		fetch c_takes_part into takes_part_rec;

	end loop;

	close c_takes_part;

END;
/

BEGIN 
   delete_team('2222BBBB'); 
END;
/





