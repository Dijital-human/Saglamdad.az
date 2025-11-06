// Change Password API Route
// /az/ Parol dəyişdirmə API route-u
// /en/ Change password API route

import { NextRequest, NextResponse } from "next/server";
import { verifyToken } from "@/lib/auth";
import { changePassword } from "@/lib/auth";

// /az/ Parolu dəyişdirir (admin tələb olunur)
// /en/ Change password (admin required)
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

    const { currentPassword, newPassword } = await request.json();

    // /az/ Validation
    // /en/ Validation
    if (!currentPassword || !newPassword) {
      return NextResponse.json(
        { error: "Cari parol və yeni parol məcburidir / Current password and new password are required" },
        { status: 400 }
      );
    }

    if (newPassword.length < 6) {
      return NextResponse.json(
        { error: "Yeni parol ən azı 6 simvol olmalıdır / New password must be at least 6 characters" },
        { status: 400 }
      );
    }

    // /az/ Cari parolu yoxla
    // /en/ Verify current password
    const { verifyPassword } = await import("@/lib/auth");
    const { getAdmin } = await import("@/lib/db");
    const admin = await getAdmin();
    const isValidPassword = await verifyPassword(currentPassword, admin.password);

    if (!isValidPassword) {
      return NextResponse.json(
        { error: "Cari parol yanlışdır / Current password is incorrect" },
        { status: 400 }
      );
    }

    // /az/ Parolu dəyişdir
    // /en/ Change password
    await changePassword(newPassword);

    return NextResponse.json({ success: true, message: "Parol uğurla dəyişdirildi / Password changed successfully" });
  } catch (error) {
    console.error("Error changing password:", error);
    return NextResponse.json(
      { error: "Parol dəyişdirilə bilmədi / Failed to change password" },
      { status: 500 }
    );
  }
}

