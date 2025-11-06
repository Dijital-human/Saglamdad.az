// Contact API Route
// /az/ Əlaqə API route-u
// /en/ Contact API route

import { NextRequest, NextResponse } from "next/server";
import { getContact, saveContact } from "@/lib/db";
import { verifyToken } from "@/lib/auth";

// /az/ Əlaqə məlumatlarını gətirir
// /en/ Get contact information
export async function GET() {
  try {
    const contact = await getContact();
    return NextResponse.json(contact);
  } catch (error) {
    return NextResponse.json(
      { error: "Əlaqə məlumatları gətirilə bilmədi / Failed to fetch contact information" },
      { status: 500 }
    );
  }
}

// /az/ Əlaqə məlumatlarını yeniləyir (admin tələb olunur)
// /en/ Update contact information (admin required)
export async function POST(request: NextRequest) {
  try {
    // Auth check
    const authHeader = request.headers.get("authorization");
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const token = authHeader.substring(7);
    if (!verifyToken(token)) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const contact = await request.json();
    await saveContact(contact);
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: "Əlaqə məlumatları saxlanıla bilmədi / Failed to save contact information" },
      { status: 500 }
    );
  }
}

