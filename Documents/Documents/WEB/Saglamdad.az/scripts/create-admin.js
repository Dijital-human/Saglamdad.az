// Script to create admin user with hashed password
// /az/ Admin istifadəçi yaratmaq üçün script
// /en/ Script to create admin user with hashed password

const bcrypt = require("bcryptjs");

async function createAdmin() {
  const password = "admin123";
  const hashedPassword = await bcrypt.hash(password, 10);
  
  console.log("Admin credentials:");
  console.log("Username: admin");
  console.log("Password: admin123");
  console.log("\nHashed password:");
  console.log(hashedPassword);
  
  const adminData = {
    username: "admin",
    password: hashedPassword
  };
  
  console.log("\nAdmin JSON:");
  console.log(JSON.stringify(adminData, null, 2));
}

createAdmin().catch(console.error);

