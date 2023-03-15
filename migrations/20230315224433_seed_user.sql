-- User 1
INSERT INTO users (id, username, email) VALUES ('c894a480-b3e2-41ea-af47-e9fdd8ff4d7b', 'jin', 'jin@email.com');
INSERT INTO trades (user_id, instrument, action, quantity, price, time, commission, account_display_name)
VALUES ('c894a480-b3e2-41ea-af47-e9fdd8ff4d7b', 'ES-6-23', 'buy', 1, 3998.25, 44984.2725966435, 2.04, 'sim101');
INSERT INTO trades (user_id, instrument, action, quantity, price, time, commission, account_display_name)
VALUES ('c894a480-b3e2-41ea-af47-e9fdd8ff4d7b', 'ES-6-23', 'sell', 1, 4000.25, 44984.273233125, 2.04, 'sim101');

INSERT INTO users (id, username, email) VALUES ('c894a480-b3e2-41ea-af47-e9fdd8ff4d7c', 'barry', 'barry@email.com');
INSERT INTO users (id, username, email) VALUES ('c894a480-b3e2-41ea-af47-e9fdd8ff4d7d', 'tina', 'tina@email.com');
INSERT INTO users (id, username, email) VALUES ('c894a480-b3e2-41ea-af47-e9fdd8ff4d7e', 'karen', 'karen@email.com');
