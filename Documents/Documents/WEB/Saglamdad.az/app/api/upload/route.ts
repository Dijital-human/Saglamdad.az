// File Upload API Route
// /az/ Fayl yükləmə API route-u
// /en/ File upload API route

import { NextRequest, NextResponse } from "next/server";
import { writeFile, mkdir } from "fs/promises";
import { existsSync } from "fs";
import path from "path";
import { verifyToken } from "@/lib/auth";

// /az/ Maksimum fayl ölçüsü: 10MB
// /en/ Maximum file size: 10MB
const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB

// /az/ İcazə verilən fayl formatları
// /en/ Allowed file formats
const ALLOWED_IMAGE_TYPES = ["image/jpeg", "image/jpg", "image/png", "image/webp"];
const ALLOWED_VIDEO_TYPES = ["video/mp4", "video/webm", "video/ogg"];

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

    const formData = await request.formData();
    const file = formData.get("file") as File;
    const type = formData.get("type") as string; // "image" or "video"

    if (!file) {
      return NextResponse.json(
        { error: "Fayl seçilməyib / No file selected" },
        { status: 400 }
      );
    }

    // /az/ Fayl ölçüsünü yoxla
    // /en/ Check file size
    if (file.size > MAX_FILE_SIZE) {
      return NextResponse.json(
        { error: "Fayl çox böyükdür (max 10MB) / File too large (max 10MB)" },
        { status: 400 }
      );
    }

    // /az/ Fayl tipini yoxla
    // /en/ Check file type
    if (type === "image" && !ALLOWED_IMAGE_TYPES.includes(file.type)) {
      return NextResponse.json(
        { error: "Rəsm formatı dəstəklənmir (JPEG, PNG, WebP) / Image format not supported" },
        { status: 400 }
      );
    }

    if (type === "video" && !ALLOWED_VIDEO_TYPES.includes(file.type)) {
      return NextResponse.json(
        { error: "Video formatı dəstəklənmir (MP4, WebM, OGG) / Video format not supported" },
        { status: 400 }
      );
    }

    // /az/ Uploads folder yaradır
    // /en/ Creates uploads folder
    const uploadsDir = path.join(process.cwd(), "public", "uploads", type);
    if (!existsSync(uploadsDir)) {
      await mkdir(uploadsDir, { recursive: true });
    }

    // /az/ Unikal fayl adı yaradır
    // /en/ Creates unique file name
    const timestamp = Date.now();
    const randomString = Math.random().toString(36).substring(2, 15);
    const fileExtension = file.name.split(".").pop();
    const fileName = `${timestamp}-${randomString}.${fileExtension}`;
    const filePath = path.join(uploadsDir, fileName);

    // /az/ Faylı yazır
    // /en/ Writes file
    const bytes = await file.arrayBuffer();
    const buffer = Buffer.from(bytes);
    await writeFile(filePath, buffer);

    // /az/ URL qaytarır
    // /en/ Returns URL
    const url = `/uploads/${type}/${fileName}`;

    return NextResponse.json({ url, fileName });
  } catch (error) {
    console.error("Upload error:", error);
    return NextResponse.json(
      { error: "Yükləmə zamanı xəta baş verdi / Upload error occurred" },
      { status: 500 }
    );
  }
}

