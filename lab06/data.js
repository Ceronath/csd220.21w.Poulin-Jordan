import Database from 'better-sqlite3';

class DataAccess {

    constructor() {
        this.db = new Database('db.sqlite');
    }

    getUserByUsername(username) {
        let user = null;
        
        const statement = this.db.prepare("SELECT id, username, password FROM user WHERE username = ?");
        return statement.get(username);
    }

    getUsers() {
        const statement = this.db.prepare("SELECT id, username, password FROM user ORDER BY username");
        return statement.all();
    }

    addUser(name, passwordHash) {
        console.log(name, passwordHash);
        const statement = this.db.prepare("INSERT INTO user (username, password) VALUES (?, ?)");
        statement.run(name, passwordHash);
    }

    deleteUser(id) {
        const statement = this.db.prepare("DELETE FROM user WHERE id = ?");
        statement.run(id);
    }

}

export { DataAccess }