// Authentication Login API Route
// /az/ Giriş API route-u
// /en/ Login API route

import { NextRequest, NextResponse } from "next/server";
import { login } from "@/lib/auth";

export async function POST(request: NextRequest) {
  try {
    const { username, password } = await request.json();

    if (!username || !password) {
      return NextResponse.json(
        { error: "İstifadəçi adı və şifrə tələb olunur / Username and password required" },
        { status: 400 }
      );
    }

    const token = await login(username, password);

    if (!token) {
      return NextResponse.json(
        { error: "İstifadəçi adı və ya şifrə yanlışdır / Invalid credentials" },
        { status: 401 }
      );
    }

    return NextResponse.json({ token });
  } catch (error) {
    return NextResponse.json(
      { error: "Xəta baş verdi / Error occurred" },
      { status: 500 }
    );
  }
}

