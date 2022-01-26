Allow new users to register accounts:
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    fullname VARCHAR(25) UNIQUE NOT NULL,
    email_address VARCHAR(50) UNIQUE,
    mobile_number TEXT UNIQUE NOT NULL 
    CONSTRAINT phone_number CHECK(mobile_number ~ '^(\+\d{1,3}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{3,4}$'),
    created_on TIMESTAMPTZ,
    last_login TIMESTAMPTZ
);
CREATE UNIQUE INDEX find_users_by_name ON users (LOWER(fullname));
CREATE INDEX find_users_by_partial_name ON users (fullname VARCHAR_PATTERN_OPS);
CREATE INDEX users_last_login ON users (last_login);



-- OPTIONS to register with Mobile Number.
-- My 2 cents:  Concatenating data is easier than extracting data from a larger element.

-- I'd use different fields (country code, area code, phone number, extension, etc.) and instruct the users not to use punctuation.  
-- The data will (hopefully) be a little cleaner; and easier to use.  
-- Then, if you want it all in one field, use an update query to concatenate the values with formatting characters into a separate field for easy reporting/printing.


-- Take input from the user.
-- Identify the country of the user.  (You can either use the IP address of the user to identify this or ask for country-input )
-- Check the formatting of the phone number and compare with that country’s format
-- If Invalid, prompt the user to re-enter
-- If Valid, convert the format into E.164 in string and store in your DB.
-- CONSTRAINT phone_number CHECK(VALUE ~ '^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$')
-- Use ^from-string-start and $to-string-end to validate numeric ranges. The ^ and $ ensure that the input string consists ONLY of those characters - otherwise it is not guaranteed that the input string is not larger
-- /^(?:(?:\(?(?:00|\+)([1-4]\d\d|[1-9]\d?)\)?)?[\-\.\ \\\/]?)?((?:\(?\d{1,}\)?[\-\.\ \\\/]?){0,})(?:[\-\.\ \\\/]?(?:#|ext\.?|extension|x)[\-\.\ \\\/]?(\d+))?$/i
-- ^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$



-- FROM: https://stackoverflow.com/questions/16699007/regular-expression-to-match-standard-10-digit-phone-number
-- There are many variations possible for this problem. Here is a regular expression similar to an answer I previously placed on SO.

-- ^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$

-- Regardless of the way the phone number is entered, the capture groups can be used to breakdown the phone number so you can process it in your code.

-- Group1: Country Code (ex: 1 or 86)
-- Group2: Area Code (ex: 800)
-- Group3: Exchange (ex: 555)
-- Group4: Subscriber Number (ex: 1234)
-- Group5: Extension (ex: 5678)
-- Here is a breakdown of the expression if you're interested:

-- ^\s*                #Line start, match any whitespaces at the beginning if any.
-- (?:\+?(\d{1,3}))?   #GROUP 1: The country code. Optional.
-- [-. (]*             #Allow certain non numeric characters that may appear between the Country Code and the Area Code.
-- (\d{3})             #GROUP 2: The Area Code. Required.
-- [-. )]*             #Allow certain non numeric characters that may appear between the Area Code and the Exchange number.
-- (\d{3})             #GROUP 3: The Exchange number. Required.
-- [-. ]*              #Allow certain non numeric characters that may appear between the Exchange number and the Subscriber number.
-- (\d{4})             #Group 4: The Subscriber Number. Required.
-- (?: *x(\d+))?       #Group 5: The Extension number. Optional.
-- \s*$                #Match any ending whitespaces if any and the end of string.
-- See this YOUTUBE Video: https://www.google.com/search?newwindow=1&rlz=1C1CHBF_en-GBGB964GB964&lei=X_brYb31OeiFhbIPnrWomAw&q=10%20digit%20phone%20number%20regex&ved=2ahUKEwj9oIaBrMX1AhXoQkEAHZ4aCsMQsKwBKAB6BAhCEAE&biw=1920&bih=937&dpr=1#kpvalbx=_rvfrYdyYHIuegQanspG4Aw19


-- Seeding the database

INSERT INTO users (name, email, mobile_no, password) VALUES ('Khoero Eixas', 'ke@eixas.com', '+243 654 928 7310');

ALTER TABLE users ADD COLUMN password VARCHAR(25);

UPDATE users SET password ='mitur38x@$' WHERE fullname = 'Khoero Eixas';


ALTER TABLE users RENAME COLUMN mobile_number TO mobile_no;

DELETE FROM users WHERE id = 1;
