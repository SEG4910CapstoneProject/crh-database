INSERT INTO users (email, password_hash, role)
VALUES
    -- Bcrypt hash values for passwords (strength 10)
    -- Mock passwords are "password"
    -- https://bcrypt-generator.com/
  ('admin@example.com', '$2a$12$qOJPeE2THKiy3GxAq1TQS.USq9VZO8MGIvJyldIvQpPO8gqP35VQi', 'admin'),
  ('analyst@example.com', '$2a$12$qOJPeE2THKiy3GxAq1TQS.USq9VZO8MGIvJyldIvQpPO8gqP35VQi', 'analyst'),
  ('restricted@example.com', '$2a$12$qOJPeE2THKiy3GxAq1TQS.USq9VZO8MGIvJyldIvQpPO8gqP35VQi', 'restricted_analyst');
