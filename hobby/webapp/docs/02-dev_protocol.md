# 02. Development Protocol

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

Development rules and best practices for building web applications. Follow these guidelines to maintain code quality and enable smooth AI collaboration.

---

## 1. Project Setup

### Required Files
```
my-webapp/
├── .env                 # Secrets (NEVER commit!)
├── .env.example         # Template for environment variables
├── .gitignore           # Git ignore rules
├── README.md            # Project overview
├── package.json         # Dependencies
├── frontend/
│   └── src/
└── backend/            # Optional if using Supabase
    └── src/
```

### .gitignore
```
# Environment
.env
.env.local
.env.production

# Dependencies
node_modules/
venv/
__pycache__/

# Build
dist/
build/
.next/
.vercel/

# Database
*.db
*.sqlite

# Logs
*.log
logs/

# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
```

### .env.example
```
# Database
DATABASE_URL=postgresql://user:pass@host:5432/dbname
# or
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_anon_key

# API
VITE_API_URL=http://localhost:8000

# Auth (if using)
JWT_SECRET=your_secret_key
```

---

## 2. Coding Standards

### DO ✅
- **Use TypeScript** (or JSDoc for JavaScript)
- **Component-based architecture**: Small, reusable components
- **Descriptive names**: `UserProfile` not `UP`, `fetchUsers` not `get`
- **Single responsibility**: One component = one purpose
- **Environment variables**: Never hardcode API URLs or secrets
- **Async/await**: Avoid callback hell
- **Error boundaries**: Catch React errors gracefully
- **Validate inputs**: Both frontend and backend
- **Use const/let**: Never use var
- **Comment complex logic**: Explain WHY, not WHAT

### DON'T ❌
- **Don't commit .env files**: Use .env.example
- **Don't hardcode secrets**: Use environment variables
- **Don't skip validation**: Validate on both client and server
- **Don't ignore errors**: Always handle errors
- **Don't expose stack traces**: Show friendly errors to users
- **Don't skip .gitignore**: Set up before first commit
- **Don't use inline styles excessively**: Use CSS modules or Tailwind
- **Don't fetch in useEffect without cleanup**: Prevent memory leaks

---

## 3. Project Structure

### Frontend (React + Vite)
```
frontend/
├── src/
│   ├── components/      # Reusable UI components
│   │   ├── Button.jsx
│   │   └── TaskCard.jsx
│   ├── pages/          # Page components
│   │   ├── Home.jsx
│   │   └── Dashboard.jsx
│   ├── hooks/          # Custom React hooks
│   │   └── useAuth.js
│   ├── services/       # API calls
│   │   └── api.js
│   ├── utils/          # Helper functions
│   │   └── formatDate.js
│   ├── App.jsx
│   └── main.jsx
├── public/             # Static assets
├── index.html
└── vite.config.js
```

### Backend (Optional - Use Supabase Instead)
```
backend/
├── src/
│   ├── routes/         # API endpoints
│   ├── controllers/    # Request handlers
│   ├── services/       # Business logic
│   ├── models/         # Database models
│   ├── middleware/     # Auth, validation
│   └── index.js
├── .env
└── package.json
```

---

## 4. Git Workflow

### Commit Messages
```bash
# Good commits
git commit -m "Add user authentication"
git commit -m "Fix task deletion bug"
git commit -m "Update dashboard layout"

# Bad commits
git commit -m "update"
git commit -m "fix"
git commit -m "changes"
```

**Format:** `<verb> <what>` in present tense
- Add, Fix, Update, Remove, Refactor, Optimize

### Branching (Optional for Solo)
```bash
# Solo - just use main
git add .
git commit -m "Add feature"
git push

# Team - use feature branches
git checkout -b feature/add-auth
git commit -m "Add login page"
git push origin feature/add-auth
```

---

## 5. Component Guidelines

### DO ✅
```jsx
// Good: Small, focused component
function TaskCard({ task, onComplete }) {
  return (
    <div className="task-card">
      <h3>{task.title}</h3>
      <button onClick={() => onComplete(task.id)}>
        Complete
      </button>
    </div>
  );
}

// Good: Custom hook for logic
function useTasks() {
  const [tasks, setTasks] = useState([]);
  
  useEffect(() => {
    fetchTasks().then(setTasks);
  }, []);
  
  return { tasks };
}
```

### DON'T ❌
```jsx
// Bad: Too much in one component
function Dashboard() {
  // 500 lines of code mixing logic and UI
}

// Bad: Inline complex logic
<button onClick={() => {
  // 20 lines of logic here
}}>
```

---

## 6. API Integration

### Using Supabase (Recommended)
```javascript
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_ANON_KEY
);

// Fetch data
const { data, error } = await supabase
  .from('tasks')
  .select('*')
  .order('created_at', { ascending: false });

if (error) {
  console.error('Error:', error);
  return;
}

// Use data
```

### Using Custom API
```javascript
// services/api.js
const API_URL = import.meta.env.VITE_API_URL;

export async function fetchTasks() {
  const response = await fetch(`${API_URL}/tasks`);
  
  if (!response.ok) {
    throw new Error('Failed to fetch tasks');
  }
  
  return response.json();
}

// In component
import { fetchTasks } from '../services/api';

function TaskList() {
  const [tasks, setTasks] = useState([]);
  
  useEffect(() => {
    fetchTasks()
      .then(setTasks)
      .catch(err => console.error(err));
  }, []);
}
```

---

## 7. Error Handling

### DO ✅
```jsx
// Frontend error boundary
class ErrorBoundary extends React.Component {
  state = { hasError: false };
  
  static getDerivedStateFromError(error) {
    return { hasError: true };
  }
  
  render() {
    if (this.state.hasError) {
      return <div>Something went wrong. Please refresh.</div>;
    }
    return this.props.children;
  }
}

// API error handling
async function handleSubmit() {
  try {
    await createTask(taskData);
    toast.success('Task created!');
  } catch (error) {
    toast.error('Failed to create task. Try again.');
    console.error(error);
  }
}
```

### DON'T ❌
```jsx
// Don't ignore errors
fetch('/api/tasks'); // No error handling ❌

// Don't expose technical errors
catch (error) {
  alert(error.stack); // ❌
}
```

---

## 8. Security Rules

### Secrets Management
✅ **DO:**
- Use .env for all secrets
- Add .env to .gitignore
- Provide .env.example template
- Prefix public env vars with `VITE_` (Vite) or `NEXT_PUBLIC_` (Next.js)

❌ **DON'T:**
- Hardcode API keys
- Commit .env files
- Expose backend secrets in frontend

### Input Validation
```javascript
// Frontend validation
function validateEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(email);
}

// Always validate on backend too!
```

---

## 9. State Management

### Start Simple
```jsx
// Local state for simple data
const [count, setCount] = useState(0);

// Context for shared data
const UserContext = createContext();
```

### Scale When Needed
```
1. useState (component-level)
   ↓
2. Context API (app-level)
   ↓
3. Zustand/Redux (complex apps)
```

---

## 10. Styling

### DO ✅
```jsx
// Tailwind (recommended for hobby projects)
<button className="bg-blue-500 hover:bg-blue-600 px-4 py-2 rounded">
  Click me
</button>

// CSS Modules
import styles from './Button.module.css';
<button className={styles.primary}>Click me</button>
```

### DON'T ❌
```jsx
// Avoid inline styles for everything
<div style={{ marginTop: '20px', color: 'red' }}>❌</div>

// Don't mix too many styling approaches
```

---

## 11. Performance

### DO ✅
- Lazy load routes: `const Home = lazy(() => import('./Home'))`
- Memoize expensive calculations: `useMemo`
- Avoid unnecessary re-renders: `React.memo`, `useCallback`
- Optimize images: Use WebP, lazy loading
- Code splitting: Split by route

### DON'T ❌
- Don't fetch in every render
- Don't create functions in render
- Don't skip key props in lists
- Don't load entire libraries for one function

---

## 12. Testing

### Manual Testing Checklist
- [ ] App loads without errors
- [ ] All buttons work
- [ ] Forms validate correctly
- [ ] Error messages are friendly
- [ ] Works on mobile (responsive)
- [ ] Works in different browsers

### Test User Flows
```
1. Open app
2. Create account / login
3. Create item
4. Edit item
5. Delete item
6. Logout
```

---

## 13. Deployment

### Pre-deployment Checklist
- [ ] .gitignore includes .env
- [ ] .env.example created
- [ ] All environment variables configured
- [ ] Build runs without errors: `npm run build`
- [ ] Tested production build locally
- [ ] Error handling in place
- [ ] README updated

### Vercel Deployment
```bash
# 1. Push to GitHub
git push origin main

# 2. Import to Vercel
# - Connect GitHub repo
# - Add environment variables
# - Deploy!

# Auto-deploys on every push to main
```

### Environment Variables
```bash
# Frontend (Vercel)
VITE_SUPABASE_URL=xxx
VITE_SUPABASE_ANON_KEY=xxx
VITE_API_URL=xxx

# Backend (Render/Railway)
DATABASE_URL=xxx
JWT_SECRET=xxx
```

---

## 14. AI Collaboration Rules

### For AI Assistants
✅ **DO:**
- Follow this protocol strictly
- Use TypeScript/JSDoc
- Add error handling
- Provide clear comments
- Use environment variables
- Suggest best practices
- Point out security issues
- Use modern React patterns (hooks)

❌ **DON'T:**
- Hardcode secrets
- Skip validation
- Use class components (use hooks)
- Create overly complex solutions
- Ignore accessibility
- Skip error boundaries

### For Developers
✅ **DO:**
- Review AI-generated code
- Test before committing
- Ask for explanations
- Request best practices
- Use AI for boilerplate

❌ **DON'T:**
- Blindly copy-paste
- Skip security review
- Deploy untested code

---

## 15. Database

### Use Supabase (Recommended)
```javascript
// No backend needed!
// Supabase provides:
// - PostgreSQL database
// - Authentication
// - Real-time subscriptions
// - Storage
// - Edge functions
```

### If Custom Backend
```javascript
// Use environment variables
const db = await createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

// Always use parameterized queries
db.query('SELECT * FROM users WHERE id = ?', [userId]);
```

---

## 16. Logging

### What to Log
```javascript
// Production errors
console.error('[ERROR]', error.message);

// Important actions (backend)
console.log('[INFO] User logged in:', userId);
```

### What NOT to Log
```javascript
// DON'T log secrets
console.log('API Key:', process.env.API_KEY); // ❌

// DON'T log personal data
console.log('User email:', user.email); // ❌

// DON'T log excessively
console.log('Function called'); // ❌
```

---

## 17. Accessibility

### DO ✅
```jsx
// Use semantic HTML
<button>Click me</button>
<nav>...</nav>
<main>...</main>

// Add alt text
<img src="..." alt="User profile picture" />

// Use labels
<label htmlFor="email">Email</label>
<input id="email" type="email" />
```

---

## 18. Upgrade Path

### When to Refactor
- Component > 200 lines → Split into smaller components
- File > 300 lines → Extract logic to hooks/utils
- More than 5 API calls → Create API service layer
- State getting complex → Add Zustand/Redux
- Need server logic → Add backend or use Supabase Edge Functions

---

## Cross-References
- See [01-context.md](01-context.md) for project goals
- See [03-product_requirements.md](03-product_requirements.md) for features

---

> **Remember:** These rules keep your code clean, secure, and maintainable. Follow them from day one! 🚀
