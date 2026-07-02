$ErrorActionPreference = "Stop"

$RepoRoot = $PSScriptRoot
$ProjectDir = Join-Path $RepoRoot "MULTI-AGENT-CANDIDATE-SELECTION"
$EnvDir = Join-Path $ProjectDir "env-macs"

Write-Host ""
Write-Host "=== Multi-Agent Candidate Selection - Setup ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ProjectDir)) {
    Write-Host "ERROR: Could not find MULTI-AGENT-CANDIDATE-SELECTION folder next to this script." -ForegroundColor Red
    exit 1
}

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
    Write-Host "ERROR: Python was not found on PATH. Install Python 3.9+ from https://www.python.org/downloads/ and try again." -ForegroundColor Red
    exit 1
}

Write-Host "[1/4] Creating virtual environment 'env-macs'..." -ForegroundColor Yellow
if (Test-Path $EnvDir) {
    Write-Host "      Already exists, skipping creation."
} else {
    python -m venv $EnvDir
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to create the virtual environment." -ForegroundColor Red
        exit 1
    }
}

$venvPython = Join-Path $EnvDir "Scripts\python.exe"

Write-Host "[2/4] Upgrading pip..." -ForegroundColor Yellow
& $venvPython -m pip install --upgrade pip
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to upgrade pip." -ForegroundColor Red
    exit 1
}

Write-Host "[3/4] Installing Python dependencies (this can take a while, several GB are downloaded)..." -ForegroundColor Yellow
& $venvPython -m pip install -r (Join-Path $ProjectDir "requirements.txt")
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Dependency installation failed. See the output above for details." -ForegroundColor Red
    exit 1
}

Write-Host "[4/4] Installing frontend dependencies (npm install)..." -ForegroundColor Yellow
$npm = Get-Command npm -ErrorAction SilentlyContinue
if (-not $npm) {
    Write-Host "      npm not found on PATH, skipping frontend setup. Install Node.js 18+ from https://nodejs.org/ then run 'npm install' inside the frontend folder." -ForegroundColor DarkYellow
} else {
    Push-Location (Join-Path $ProjectDir "frontend")
    npm install
    $npmExit = $LASTEXITCODE
    Pop-Location
    if ($npmExit -ne 0) {
        Write-Host "ERROR: npm install failed." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "=================================================" -ForegroundColor Green
Write-Host " Everything is ready!" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Add your Groq/Gemini API keys to MULTI-AGENT-CANDIDATE-SELECTION\Config.yaml (optional)."
Write-Host "  2. Start the backend:"
Write-Host "       MULTI-AGENT-CANDIDATE-SELECTION\env-macs\Scripts\python.exe MULTI-AGENT-CANDIDATE-SELECTION\backend_api.py"
Write-Host "  3. In another terminal, start the frontend:"
Write-Host "       cd MULTI-AGENT-CANDIDATE-SELECTION\frontend"
Write-Host "       npm run dev"
Write-Host "  4. Open http://localhost:5173 in your browser."
Write-Host ""
