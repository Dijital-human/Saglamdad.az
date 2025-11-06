// Product Delete API Route
// /az/ Məhsul silmə API route-u
// /en/ Product delete API route

import { NextRequest, NextResponse } from "next/server";
import { getProducts, deleteProduct } from "@/lib/db";
import { verifyToken } from "@/lib/auth";

// /az/ Məhsulu silir (admin tələb olunur)
// /en/ Delete product (admin required)
export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
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

    await deleteProduct(params.id);
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: "Məhsul silinə bilmədi / Failed to delete product" },
      { status: 500 }
    );
  }
}

