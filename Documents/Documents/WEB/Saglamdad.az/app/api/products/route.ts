// Products API Route
// /az/ Məhsullar API route-u
// /en/ Products API route

import { NextRequest, NextResponse } from "next/server";
import { getProducts, saveProducts } from "@/lib/db";
import { verifyToken } from "@/lib/auth";

// /az/ Bütün məhsulları gətirir
// /en/ Get all products
export async function GET() {
  try {
    const products = await getProducts();
    return NextResponse.json(products);
  } catch (error) {
    return NextResponse.json(
      { error: "Məhsullar gətirilə bilmədi / Failed to fetch products" },
      { status: 500 }
    );
  }
}

// /az/ Yeni məhsul əlavə edir (admin tələb olunur)
// /en/ Add new product (admin required)
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

    const products = await request.json();
    await saveProducts(products);
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: "Məhsul saxlanıla bilmədi / Failed to save products" },
      { status: 500 }
    );
  }
}

