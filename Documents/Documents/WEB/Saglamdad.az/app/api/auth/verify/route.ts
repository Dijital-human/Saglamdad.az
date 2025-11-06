// Authentication Verify API Route
// /az/ Token yoxlama API route-u
// /en/ Token verification API route

import { NextRequest, NextResponse } from "next/server";
import { verifyToken } from "@/lib/auth";

export async function GET(request: NextRequest) {
  try {
    const authHeader = request.headers.get("authorization");
    
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const token = authHeader.substring(7);
    const isValid = verifyToken(token);

    if (!isValid) {
      return NextResponse.json({ error: "Invalid token" }, { status: 401 });
    }

    return NextResponse.json({ valid: true });
  } catch (error) {
    return NextResponse.json({ error: "Error verifying token" }, { status: 500 });
  }
}

