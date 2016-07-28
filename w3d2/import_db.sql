CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Sisi', 'Yao'),
  ('Tyler', 'Torola');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Test q 1', 'Why?', (SELECT id FROM users WHERE fname = 'Sisi')),
  ('Test q 2', 'Why?\nWho?', (SELECT id FROM users WHERE fname = 'Tyler')),
  ('Test q 3', 'HOW?\nWho?', (SELECT id FROM users WHERE fname = 'Tyler'));

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Sisi'), (SELECT id FROM questions WHERE title = 'Test q 1')),
  ((SELECT id FROM users WHERE fname = 'Sisi'), (SELECT id FROM questions WHERE title = 'Test q 2')),
  ((SELECT id FROM users WHERE fname = 'Tyler'), (SELECT id FROM questions WHERE title = 'Test q 2'));

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Test q 1'), NULL,(SELECT id FROM users WHERE fname = 'Sisi'), 'Because'),
  ((SELECT id FROM questions WHERE title = 'Test q 1'), 1, (SELECT id FROM users WHERE fname = 'Tyler'), 'I don''t know?' );

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Sisi'), (SELECT id FROM questions WHERE title = 'Test q 2')),
  ((SELECT id FROM users WHERE fname = 'Tyler'), (SELECT id FROM questions WHERE title = 'Test q 1'));
