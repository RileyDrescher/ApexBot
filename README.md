# APEXBOT — AI Trading System

A full-stack AI trading system: website, backend API, and trading bot.

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                    YOUR BROWSER                      │
│              frontend/index.html                     │
│   Dashboard | Signals | Journal | Performance        │
└───────────────────┬─────────────────────────────────┘
                    │  HTTP polling + WebSocket
                    ▼
┌─────────────────────────────────────────────────────┐
│              BACKEND SERVER (Flask)                  │
│              backend/server.py :5000                 │
│                                                      │
│  GET  /api/signals     ← frontend reads signals     │
│  POST /api/signals     ← bot posts signals HERE     │
│  GET  /api/trades      ← frontend reads trades      │
│  POST /api/trades      ← bot posts trades HERE      │
│  GET  /api/health      ← heartbeat check            │
│  ws   /ws              ← real-time push             │
└───────────────────┬─────────────────────────────────┘
                    │  HTTP POST
                    ▼
┌─────────────────────────────────────────────────────┐
│              TRADING BOT (Python)                    │
│              bot/trader.py  ← NEXT STEP             │
│                                                      │
│  • Watches markets (via broker API / data feed)     │
│  • Calls Claude AI for signal reasoning             │
│  • Posts signals → /api/signals                     │
│  • (Optional) executes trades via broker            │
│  • Posts trade results → /api/trades               │
└─────────────────────────────────────────────────────┘
```

## Setup

### 1. Install dependencies
```bash
pip install flask flask-cors flask-sock
```

### 2. Start the backend server
```bash
cd backend
python server.py
```
Server runs at http://localhost:5000

### 3. Open the website
Visit http://localhost:5000 in your browser.
Or open frontend/index.html directly (use Settings to point to your backend URL).

### 4. Load demo data (optional, to see the UI in action)
```bash
curl -X POST http://localhost:5000/api/demo/seed
```

### 5. Configure your strategy
Go to Strategy Brain → enter your trading rules → Save.

### 6. Start the bot (coming next)
```bash
cd bot
python trader.py
```

## API Reference

### POST /api/signals
Bot sends signals to the website:
```json
{
  "symbol": "BTC/USD",
  "signal": "BUY",
  "price": "67420",
  "timeframe": "1H",
  "entry": "67200",
  "stop_loss": "65800",
  "target1": "69500",
  "target2": "72000",
  "risk_reward": "1:2.3",
  "confidence": 78,
  "reasoning": "Price swept equal lows at 66,800, forming a BOS on 15m. HTF bias bullish. FVG between 67,100-67,300 is the entry zone.",
  "warnings": "FOMC minutes tomorrow — position size accordingly"
}
```

### POST /api/trades
Bot sends trade records:
```json
{
  "signal_id": "abc123",
  "symbol": "BTC/USD",
  "signal": "BUY",
  "entry": "67200",
  "stop_loss": "65800",
  "target1": "69500",
  "size": 1000,
  "result": "open"
}
```

### PATCH /api/trades/{id}
Update a trade when it closes:
```json
{
  "exit": "69450",
  "pnl": 342.50,
  "result": "win"
}
```

## File Structure
```
apexbot/
├── frontend/
│   ├── index.html      ← Main website
│   ├── style.css       ← All styles
│   └── app.js          ← Frontend logic
├── backend/
│   └── server.py       ← Flask API + WebSocket
├── bot/
│   └── trader.py       ← Trading bot (next step)
└── README.md
```
