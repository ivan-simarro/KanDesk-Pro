-- ENUM: TASK PRIORITY
CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high', 'urgent', 'critical', 'blocker');

-- USERS TABLE
CREATE TABLE users (
    id UUID PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- BOARDS TABLE
CREATE TABLE boards (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    owner_id UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE
);

-- COLUMNS TABLE
CREATE TABLE columns (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position INTEGER NOT NULL,
    board_id INTEGER NOT NULL,
    FOREIGN KEY (board_id) REFERENCES boards(id) ON DELETE CASCADE
);

-- TASKS TABLE
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    position INTEGER NOT NULL,
    due_date DATE,
    priority task_priority DEFAULT 'medium',
    estimated_minutes INTEGER,
    spent_minutes INTEGER DEFAULT 0,
    assignee_id UUID,
    column_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (column_id) REFERENCES columns(id) ON DELETE CASCADE,
    FOREIGN KEY (assignee_id) REFERENCES users(id) ON DELETE SET NULL
);

-- TASK FILES TABLE
CREATE TABLE task_files (
    id SERIAL PRIMARY KEY,
    task_id INTEGER NOT NULL,
    file_url TEXT NOT NULL,
    file_name VARCHAR(255),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

-- TASK MESSAGES TABLE (CHAT PER TASK)
CREATE TABLE task_messages (
    id SERIAL PRIMARY KEY,
    task_id INTEGER NOT NULL,
    sender_id UUID NOT NULL,
    content TEXT NOT NULL,
    is_edited BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
);
