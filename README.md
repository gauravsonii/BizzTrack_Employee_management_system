# BizzTrack Employee Management System

BizzTrack is a full-stack web application designed to manage various aspects of a business, such as assets, employees, payroll, projects, and more. The project consists of a Node.js/Express backend with a MySQL database and a React frontend styled with Tailwind CSS.

## Features

### Backend
- **RESTful API**: Provides CRUD operations for all tables (`asset`, `attendance`, `benefit`, `client`, `department`, `employee`, `location`, `payroll`, `project`, `role`, `task`, `team`, `training`).
- **MySQL Integration**: Uses `mysql2/promise` with a connection pool for efficient database access.
- **CORS Support**: Enabled for cross-origin requests from the frontend.
- **Error Handling**: Proper HTTP status codes and error messages for API responses.

### Frontend
- **Modern UI**: A professional, visually appealing interface with a dark/light theme toggle, gradient backgrounds, and glassmorphism effects.
- **Dynamic Tables**: Displays data for each table with options to add, edit, and delete records.
- **Modal Forms**: Interactive modals for adding and editing records.
- **Animations**: Smooth transitions, slide-in sidebar, and fade-in effects.
- **Notifications**: Toast notifications for success/error feedback.
- **Responsive Design**: Fully responsive layout for mobile and desktop.
- **Error Handling**: Displays error messages if API calls fail, with a loading spinner during requests.

## Project Structure

- **Backend**:
  - `server.js`: Main backend file containing the Express server, API routes, and MySQL connection.
- **Frontend**:
  - `index.html`: Single HTML file containing the React application, styled with Tailwind CSS and using CDNs for React dependencies.

## Prerequisites

- **Node.js**: Version 14.x or higher.
- **MySQL**: Version 8.x or higher, with the `bizztrack_new` database set up.
- **Live Server**: For running the frontend (e.g., `live-server` npm package or VS Code Live Server extension).

## Setup Instructions

### 1. Database Setup
1. Install MySQL and start the server.
2. Create the `bizztrack_new` database:
   ```sql
   CREATE DATABASE bizztrack_new;
   ```
3. Set up the tables (`asset`, `attendance`, `benefit`, `client`, `department`, `employee`, `location`, `payroll`, `project`, `role`, `task`, `team`, `training`). Refer to your database schema for the table structures.
4. Populate the tables with data (as done in previous steps for tables up to `attendance` and `payroll`).

### 2. Backend Setup
1. Create a directory for the backend (e.g., `bizztrack-backend`).
2. Initialize a Node.js project:
   ```bash
   npm init -y
   ```
3. Install dependencies:
   ```bash
   npm install express mysql2 cors
   ```
4. Save the `server.js` file (provided earlier) in the backend directory.
5. Update the MySQL connection details in `server.js`:
   - Host: `localhost`
   - User: `root`
   - Password: `ur mysql password` (or your MySQL password)
   - Database: `bizztrack_new`
6. Start the backend server:
   ```bash
   node server.js
   ```
   The server will run on `http://localhost:5000`.

### 3. Frontend Setup
1. Create a directory for the frontend (e.g., `bizztrack-frontend`).
2. Save the `index.html` file (provided earlier) in the frontend directory.
3. Install `live-server` globally to serve the frontend:
   ```bash
   npm install -g live-server
   ```
4. Run the frontend:
   ```bash
   live-server
   ```
   The frontend will open in your browser at `http://localhost:8080` (or the port provided by `live-server`).

### 4. Verify the Application
- Ensure the backend is running (`http://localhost:5000`).
- Open the frontend in your browser (`http://localhost:8080`).
- Navigate through the sidebar to view, add, edit, and delete records for each table.

## Usage

- **Sidebar Navigation**: Click on any table name (e.g., `asset`, `payroll`) to view its data.
- **Add Record**: Click the "Add Record" button to open a modal and enter new data.
- **Edit Record**: Click the "Edit" button on a table row to update a record.
- **Delete Record**: Click the "Delete" button on a table row to remove a record.
- **Theme Toggle**: Use the sun/moon icon in the header to switch between dark and light themes.

## Troubleshooting

### Backend Issues
- **MySQL Connection Error**:
  - Verify the MySQL server is running.
  - Check the connection details in `server.js` (host, user, password, database).
  - Run `mysql -u root -p` and enter your password to confirm access.
- **API Not Responding**:
  - Ensure the backend server is running (`node server.js`).
  - Visit `http://localhost:5000/api/asset` in your browser to confirm the API works (you should see JSON data).

### Frontend Issues
- **Blank Page or "Nothing is Working"**:
  - Open the browser’s developer tools (F12 → Console tab) and look for errors.
  - **"Failed to fetch"**: The backend isn’t reachable. Ensure the backend is running and CORS is enabled.
  - **"SyntaxError"**: Check for JavaScript errors in `index.html`.
- **Table is Empty**:
  - Verify the table has data in the database (`SELECT * FROM asset;` in MySQL).
  - Check the browser’s Network tab for API responses (`http://localhost:5000/api/[table]`).
- **CORS Error**:
  - The backend already has CORS enabled, but ensure the backend is running before loading the frontend.

## Known Issues
- **Payroll Table Typo**: The `payroll` table uses `bonous` instead of `bonus`. The frontend and backend handle this by mapping `bonous` to `bonus`, but it’s recommended to fix the column name in the database:
  ```sql
  ALTER TABLE payroll CHANGE bonous bonus DECIMAL(10,2);
  ```

## Future Enhancements
- Add pagination for large datasets.
- Implement search and filter functionality.
- Transition to a proper React build setup (e.g., Vite or Create React App) for better performance.
- Add user authentication and authorization.

## License
This project is for educational purposes and not licensed for commercial use.

---

**Developed by Parth Nath Chauhan**
