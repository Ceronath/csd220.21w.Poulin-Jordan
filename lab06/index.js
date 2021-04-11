// TODO: Install and import the argon2 library

import promptInit from 'prompt-sync';
import { DataAccess } from './data.js';

const prompt = promptInit();

const da = new DataAccess();

(async function() {
    while ( true ) {
        console.log();
        printMenu();

        const response = prompt();

        let username = "";

        switch ( response ) {
            case "q":
                console.log("Bye!");
                process.exit();
            case "l":
                console.log("User list:");
                da.getUsers().forEach( u => console.log( u.username ));
                break;
            case "a":
                username = prompt("Add username: ");
                const password = prompt("Password: ");

                // TODO: Make sure to handle run-time errors properly
                da.addUser(username, password);  // TODO: Properly hash the password
                console.log("User '" + username + "' was added successfully!");
                
                break;
            case "d":
                username = prompt("Which user do you want to delete? ");

                const user = da.getUserByUsername(username);

                if ( user ) {

                    const password = prompt("Confirm deletion by entering the user's password: ");

                    // TODO: Make sure to handle run-time errors properly
                    if ( passwordsMatch(password, user.password) ) {
                        da.deleteUser(user.id);
                        console.log("User '" + username + "' was deleted successfully!");
                    } else {
                        console.log("You entered the wrong password");
                    }

                } else {
                    console.log("There is no user named '" + username + "'");
                }

                break;
        }

    }
})();

function hash(password) {
    // TODO: implement this function using argon2
}

function passwordsMatch(userPassword, storedPassword) {
    // TODO: do the password comparison using argon2
    return userPassword === storedPassword; 
}

function printMenu() {
    console.log("(l) List users");
    console.log("(a) Add user");
    console.log("(d) Delete user");
    console.log("(q) Quit");
}