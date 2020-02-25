-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE users
    ADD COLUMN phone_number TEXT;
ALTER TABLE users
    ADD COLUMN country_code TEXT;
ALTER TABLE users
    ADD COLUMN phone_number_confirmed BOOLEAN;
ALTER TABLE users
    ADD COLUMN authy_user_id TEXT;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE users
    DROP COLUMN phone_number;
ALTER TABLE users
    DROP COLUMN country_code;
ALTER TABLE users
    DROP COLUMN phone_number_confirmed;
ALTER TABLE users
    DROP COLUMN authy_user_id;
