# SmartPDF All In One

تطبيق Hybrid متقدم لعرض ومعالجة ملفات PDF مع ميزات OCR، الترجمة، وأدوات AI.

## 🚀 الميزات الرئيسية

### 📄 PDF Viewer (Safe Mode)
- عرض PDF مع Zoom سريع
- Page Thumbnails
- Bookmarks
- البحث في المستند
- Highlight & Notes
- Dark/Light/Sepia Mode
- بدون إعلانات داخل المشاهد

### 🌐 Translation (All Languages)
- ترجمة النص المحدد
- ترجمة PDF بالكامل
- استخراج النص ثم ترجمته
- Export PDF/Word مترجم

### 👁️ OCR (Hybrid)
- **On-device**: Tesseract OCR (سريع، بدون إنترنت)
- **Server**: PaddleOCR + Vision Transformer
  - يدعم: Arabic RTL, English, French, Chinese
  - Handwriting (للباقة العليا)
  - الجداول

### 🤖 AI Tools
- Summaries (نص مختصر)
- Extract Tables
- Extract Names/Numbers/Dates
- Clean Copy (إزالة watermark أو التنسيق السيئ)
- Rephrase

### 🔄 Conversion Tools
- PDF → Word
- Word → PDF
- PDF → Images
- Images → PDF
- OCR → Word
- Remove Metadata

### ✏️ PDF Editing Tools
- Merge, Split, Organize Pages
- Rotate, Delete Pages
- Compress
- Extract Images
- Watermark
- Password Lock

### 📁 File Manager
- Folders, Recent, Favorites
- Cloud Sync (Pro+)
- Share as PDF/Word/Image/Text

## 💰 خطط الاشتراك

### Free Plan
- Banner صغير فقط في الشاشة الرئيسية
- OCR On-device فقط
- Server OCR: 5 ملفات/شهر
- Translation: 10 نصوص أو PDF
- Summaries: 5 ملفات/شهر
- PDF → Word: ملفين
- Cloud Sync غير متاح
- Export Watermark

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

## 🛠️ Tech Stack

### Frontend
- **Flutter** - Cross-platform framework
- **pdf_render / Syncfusion Viewer** - PDF viewing
- **Tesseract OCR Mobile** - On-device OCR
- **ONNX Runtime Mobile** - AI models
- **Secure Storage** - File encryption

### Backend
- **FastAPI** - Python backend
- **PaddleOCR** - Server OCR
- **Vision Transformers** - Advanced OCR
- **Celery + Redis** - Task queue
- **PostgreSQL** - Database
- **S3 Storage** - File storage

## 📋 المتطلبات

- Flutter SDK 3.10.0 أو أحدث
- Dart 3.10.0 أو أحدث
- Android Studio / VS Code

## 🔧 التثبيت

```bash
# تثبيت ال dependencies
flutter pub get

# تشغيل المشروع
flutter run
```

## 🎨 UI/UX Style

**Gradient Theme** مع:
- Primary Colors: Blue/Turquoise, Purple/Pink, Aqua/Green
- Rounded Modern UI
- Smooth Animations
- Soft Tool Cards

## 📁 هيكل المشروع

```
lib/
├── core/
│   ├── theme/          # Gradient Theme
│   ├── router/         # Navigation
│   ├── providers/      # State Management
│   ├── services/       # Business Logic
│   └── widgets/        # Reusable Widgets
├── features/
│   ├── home/           # Home Screen
│   ├── viewer/         # PDF Viewer
│   ├── ocr/            # OCR Features
│   ├── translation/    # Translation
│   ├── ai_tools/       # AI Tools
│   ├── conversion/     # Conversion Tools
│   ├── editing/        # PDF Editing
│   ├── file_manager/   # File Manager
│   └── subscription/   # Subscription Plans
└── main.dart
```

## 🚦 Roadmap

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

## 📄 الوثائق

راجع ملف `docs/PRD_SUMMARY.md` للحصول على تفاصيل كاملة عن متطلبات المنتج.

---

**Made with ❤️ for SmartPDF**
