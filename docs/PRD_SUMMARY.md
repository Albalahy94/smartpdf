# SmartPDF All In One - PRD Summary

## Product Overview

**SmartPDF All In One** هو تطبيق Hybrid يعمل على Android وiOS يوفر مجموعة شاملة من أدوات PDF مع ميزات OCR، الترجمة، وأدوات AI.

## Target Users

- الطلاب
- الباحثين
- المحامين
- المدرسين
- موظفي الشركات
- مدون إعلانات PDF
- الأشخاص الذين يحتاجون لعرض ومعالجة PDF بسهولة
- مستخدمين يبحثون عن ترجمة وتحويل ملفات

## Core Value Proposition

1. **Safe Viewer**: عرض آمن لملفات PDF بدون إعلانات داخل المشاهد
2. **Hybrid OCR**: OCR على الجهاز وعلى السيرفر
3. **All Languages Translation**: ترجمة شاملة لجميع اللغات
4. **AI Document Tools**: أدوات ذكية لمعالجة المستندات
5. **All PDF Tools**: مجموعة كاملة من أدوات PDF

## Core Features

### A. PDF Viewer (Safe Mode)
- PDF عرض
- Zoom سريع
- Page Thumbnails
- Bookmarks
- Search in Document
- Highlight
- Notes
- Dark/Light/Sepia Mode
- بدون إعلانات داخل المشاهد نفسه

### B. Translation (All Languages)
- ترجمة النص المحدد
- ترجمة PDF بالكامل
- استخراج النص ثم ترجمته
- Export PDF/Word مترجم

### C. OCR (Hybrid)
**On-device:**
- Tesseract OCR
- مناسب للمهام السريعة دون إنترنت

**Server OCR:**
- PaddleOCR + Vision Transformer
- يدعم:
  - Arabic RTL
  - English
  - French
  - Chinese
  - Handwriting (للباقة العليا)
  - الجداول

### D. AI Tools
- Summaries (نص مختصر)
- Extract Tables
- Extract Names/Numbers/Dates
- Clean Copy (إزالة watermark أو التنسيق السيئ)
- Rephrase

### E. Conversion Tools
- PDF → Word
- Word → PDF
- PDF → Images
- Images → PDF
- OCR → Word
- Remove Metadata

### F. PDF Editing Tools
- Merge
- Split
- Organize Pages
- Rotate
- Delete Pages
- Compress
- Extract Images
- Watermark
- Password Lock

### G. File Manager
- Folders
- Recent
- Favorites
- Cloud Sync (Pro+)
- Share as PDF/Word/Image/Text

## Feature Limits (Free Plan)

- Banner صغير فقط في الشاشة الرئيسية
- OCR On-device فقط
- Server OCR: 5 ملفات/شهر
- Translation: 10 نصوص أو PDF
- Summaries: 5 ملفات/شهر
- PDF → Word: ملفين
- Cloud Sync غير متاح
- Export Watermark

## Paid Plans

### Pro — $3.99/month
- بدون إعلانات
- OCR Server: 50 ملف
- Translation: 30,000 كلمة
- PDF → Word غير محدود
- Summaries: 100 ملف
- Extract Tables
- Clean Copy
- Cloud Sync
- Scan Cleanup

### Ultimate — $7.99/month
- كل شيء غير محدود
- Handwriting OCR
- Priority Processing
- API Access
- 1GB Cloud Backup
- متقدمة PDF حماية

## User Flow

### Home
- عرض الملفات
- Recent
- Floating button: Import/Scan/Create
- Banner Ad (Free only)
- Upgrade CTA

### PDF Viewer
- جميع أدوات المشاهدة
- OCR
- Translate
- AI Tools
- Export

### AI Menu
- Summary
- Extract Data
- Rephrase
- Chat with File

### Translation Flow
- Select text → Translate
- OR: Translate whole document
- Preview
- Export

## UI/UX Style — Gradient Theme

- ألوان متداخلة
- Primary Colors:
  - Blue/Turquoise
  - Purple/Pink
  - Aqua/Green
- Rounded Modern UI
- Smooth Animations
- Soft Tool Cards

## Technical Architecture

### Frontend
- Flutter
- pdf_render / Syncfusion Viewer
- Tesseract OCR Mobile
- ONNX Runtime Mobile
- Secure Storage

### Backend
- FastAPI
- PaddleOCR
- Vision Transformers
- Celery + Redis
- PostgreSQL
- S3 Storage

### APIs
- OCR
- Translation
- AI Summary
- PDF Conversion
- Authentication
- Subscription Management

## Non-Functional Requirements

- PDF عرض في < 1 ثانية
- OCR: 5-6 ثوانٍ للصفحة
- PDF ترجمة في 12 ثانية
- Summaries: 3-5 ثوانٍ
- HTTPS Mandatory
- تشفير الملفات
- حذف تلقائي لملفات السيرفر بعد 30 دقيقة

## Monetization

- Ads (Free only)
- In-app Subscriptions
- Buy Credits
- Referral System
- Landing Page

## Roadmap

### Phase 1 — Core (Month 1–2)
- Viewer + Basic Tools
- Offline OCR
- UI Home + File Manager

### Phase 2 — AI Cloud (Month 2–4)
- Server OCR
- Translation
- PDF → Word
- Summaries

### Phase 3 — Expansion (Month 4–6)
- Cloud Sync
- Handwriting OCR
- API

---

**Source:** Smartpdf Prd.pdf

