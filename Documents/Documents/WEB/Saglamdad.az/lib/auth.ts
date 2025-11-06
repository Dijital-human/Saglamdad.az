// Authentication utility functions
// /az/ Autentifikasiya utility funksiyaları
// /en/ Authentication utility functions

import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { getAdmin, saveAdmin } from "./db";

const JWT_SECRET = process.env.JWT_SECRET || "saglamdad-secret-key-change-in-production";

// /az/ Parol yoxlama funksiyası
// /en/ Password verification function
export async function verifyPassword(password: string, hashedPassword: string): Promise<boolean> {
  return bcrypt.compare(password, hashedPassword);
}

// /az/ Parol hash funksiyası
// /en/ Password hashing function
export async function hashPassword(password: string): Promise<string> {
  return bcrypt.hash(password, 10);
}

// /az/ Giriş funksiyası - token yaradır
// /en/ Login function - creates token
export async function login(username: string, password: string): Promise<string | null> {
  const admin = await getAdmin();

  if (admin.username !== username) {
    return null;
  }

  const isValid = await verifyPassword(password, admin.password);

  if (!isValid) {
    return null;
  }

  const token = jwt.sign({ username }, JWT_SECRET, { expiresIn: "7d" });
  return token;
}

// /az/ Token yoxlama funksiyası
// /en/ Token verification function
export function verifyToken(token: string): boolean {
  try {
    jwt.verify(token, JWT_SECRET);
    return true;
  } catch {
    return false;
  }
}

// /az/ Parol dəyişdirmə funksiyası
// /en/ Password change function
export async function changePassword(newPassword: string): Promise<void> {
  const admin = await getAdmin();
  const hashedPassword = await hashPassword(newPassword);
  admin.password = hashedPassword;
  await saveAdmin(admin);
}

