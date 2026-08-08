# Ai Tasks Solutions

A white-label, Arabic-first (RTL) internal task-management platform built for managers who need a lightweight, permission-aware system to assign, track, and archive their team's work — without the overhead of enterprise project-management tools.

Built entirely on [Lovable](https://lovable.dev), backed by Supabase (Lovable Cloud), with automatic external archiving to Google Sheets and Google Drive.

---

## Overview

Ai Tasks Solutions is designed to be **remixed and re-branded per client**: each deployment gets its own isolated backend, its own Google Sheets archive, its own Drive storage, and its own logo/company name — all configurable from within the app itself, with zero code changes required for a new client.

The core idea is simple: give a manager (**Admin**) full control over assigning and closing tasks, give employees a focused view of only what's theirs, and give a business owner (**Owner**) a read-only bird's-eye view of everything — without ever exposing conversation content to someone who shouldn't see it.

## Key Features

- **Role-based access control**, enforced at the database level (Row Level Security), not just in the UI
- **Real-time task chat** per task, with replies, file attachments, and link attachments
- **Automatic status lifecycle** — new → in progress → late → closed, with an explicit "closed late" flag for tasks that were overdue before completion
- **Live analytics dashboard** — overall and per-employee pie-chart breakdowns of task load
- **Permanent external archive** — every task, message, and closure event is mirrored to a Google Sheet in real time, independent of the live database
- **File & link attachments** stored on Google Drive (not in the primary database), keeping the app lightweight
- **Email notifications** sent directly from a personal Google account when a new task is assigned
- **White-label ready** — company name and logo are runtime settings, not hardcoded values
- **Soft-delete employee offboarding** — removed employees lose access immediately, but their historical messages and task history are never deleted
- **Dark, animated, glassmorphism UI** with full right-to-left Arabic support

## Roles

| Role | Can see | Can do |
|---|---|---|
| **Owner** | All task names, statuses, counts, and archive entries | Nothing — strictly read-only, cannot open any task's chat, cannot change their own password |
| **Admin** | Everything | Create/close tasks, add/offboard employees, reset any password (including Owner's) |
| **Employee** | Only tasks assigned to them, plus their own closed-task archive | Chat, attach files/links, update their own task status |

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend & backend framework | TanStack Start (React 19) |
| Database, Auth, Realtime | Supabase (via Lovable Cloud) |
| Row-level security | PostgreSQL RLS policies |
| External text archive | Google Sheets API (Service Account, signed JWT) |
| File storage & email | Google Apps Script Web App (runs under a personal Google account — no OAuth token management, no Service Account storage-quota limitations) |
| Styling | Tailwind CSS + shadcn/ui |
| Charts | Recharts |
| Hosting | Lovable (custom domain support) |

## Architecture Highlights

- **No third-party automation platform required.** Archiving and file uploads are handled directly by server functions calling Google's APIs — no n8n, no Zapier, no middleware to maintain.
- **Google Apps Script bridges Drive uploads and email sending** through a single endpoint, authenticated by a shared secret, executing under the owner's own Google identity — meaning uploaded files live in *your* Drive, not a third-party service account with no storage of its own.
- **Every write to the live database fires an independent, non-blocking archive call** to Google Sheets, so the external log can never slow down or break the live chat experience — even if Google is temporarily unreachable.
- **Multi-tenant by design.** Each client deployment (via Lovable Remix) gets a fully isolated backend and its own set of Google integration secrets, so no data ever crosses between clients.

## Getting Started (New Client Setup)

Each new client deployment requires:

1. A Lovable Remix of this project (fresh, isolated backend).
2. Five environment secrets configured in Lovable:
   - `GOOGLE_SERVICE_ACCOUNT_JSON`
   - `GOOGLE_SHEET_ID`
   - `GOOGLE_APPS_SCRIPT_URL`
   - `GOOGLE_APPS_SCRIPT_SECRET`
   - `SEED_OWNER_TOKEN`
3. A dedicated Google Sheet (shared with the service account email) and a dedicated Google Drive folder (referenced inside the Apps Script).
4. A one-time visit to `/api/public/seed-owner?token=...` to bootstrap the first account.
5. Company name and logo set from the in-app Settings page.

## License

Proprietary — all rights reserved. This repository is a private, reusable template; it is not licensed for redistribution.
