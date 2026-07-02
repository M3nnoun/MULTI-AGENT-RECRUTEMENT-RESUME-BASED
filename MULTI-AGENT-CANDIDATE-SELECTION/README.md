# 🤖 Système Multi-Agents pour la Sélection Intelligente des Candidats

Un système automatisé de sélection de candidats utilisant une architecture multi-agents combinant RAG (LlamaIndex + ChromaDB), IA générative et raisonnement multi-agent.

## 🚀 Quick Start

**New to this project?** Start here: **[START_HERE.md](START_HERE.md)** - Complete setup guide in 3 steps!

For detailed documentation, continue reading below.

## ✨ Fonctionnalités

- **🤖 Architecture Multi-Agents**: 5 agents spécialisés évaluent les candidats sous différents angles
- **🔍 RAG Intelligent**: Recherche de candidats pertinents avec LlamaIndex et ChromaDB
- **📊 Scoring Multi-Critères**: Évaluation profil, technique et soft skills
- **⚖️ Classement Automatique**: Agent décideur génère un classement final justifié
- **📈 Rapports Détaillés**: Justifications complètes et statistiques
- **🎨 Interface Moderne**: Interface Streamlit intuitive et visuellement attrayante

## 🏗️ Architecture des Agents

Le système comprend 5 agents spécialisés:

1. **Agent RH** 📋: Lit les descriptions de poste et les critères du recruteur, génère un profil cible structuré
2. **Agent Profil** 👤: Analyse les CV et lettres de motivation (NER, scoring, extraction de compétences)
3. **Agent Technique** 💻: Évalue les compétences techniques selon les exigences du poste
4. **Agent Soft Skills** 🤝: Évalue les qualités interpersonnelles, la motivation et l'adéquation culturelle
5. **Agent Décideur** ⚖️: Agrège les avis, justifie les classements et génère un rapport final

## 🚀 Installation

### ⚡ Installation Facile (Windows)

Un script automatisé est disponible à la racine du dépôt (au-dessus de ce dossier) pour tout configurer en une seule étape. Deux façons de le lancer, au choix, depuis la racine du dépôt:

**Option A — Double-clic (ou Invite de commandes / cmd.exe)**

Double-cliquez simplement sur `setup.bat` dans l'explorateur Windows, ou depuis un terminal cmd:
```bat
setup.bat
```

**Option B — PowerShell**

Depuis un terminal PowerShell, à la racine du dépôt:
```powershell
.\setup.ps1
```
(Si l'exécution de scripts est bloquée par la politique PowerShell, utilisez plutôt: `powershell -ExecutionPolicy Bypass -File .\setup.ps1`)

Les deux options exécutent exactement le même script (`setup.bat` ne fait qu'appeler `setup.ps1`) et effectuent automatiquement:

1. La création de l'environnement virtuel Python `env-macs` dans `MULTI-AGENT-CANDIDATE-SELECTION/`
2. L'installation de toutes les dépendances Python (`requirements.txt`)
3. L'installation des dépendances du frontend React (`npm install`)
4. Un message final confirmant que tout est prêt, avec les commandes exactes pour démarrer le backend et le frontend

**Prérequis pour ce script**: Python 3.9+ et Node.js 18+ doivent déjà être installés et accessibles depuis PATH.

**Note espace disque**: l'installation complète (PyTorch, transformers, ChromaDB, modèles d'embedding) nécessite plusieurs Go d'espace libre.

Une fois le script terminé, passez directement à l'étape [Configurer les clés API](#4-configurer-les-clés-api) ci-dessous.

### Prérequis

- Python 3.9+
- pip

### Étapes d'installation

1. **Cloner le repository** (si applicable)
```bash
cd MULTI-AGENT-CANDIDATE-SELECTION
```

2. **Créer un environnement virtuel** (recommandé)
```bash
python -m venv venv
source venv/bin/activate  # Sur Windows: venv\Scripts\activate
```

3. **Installer les dépendances**

   **⚠️ IMPORTANT:** Si vous rencontrez des erreurs de dépendances (torch/torchvision), exécutez d'abord:
   
   **Windows (PowerShell):**
   ```powershell
   .\fix_dependencies.ps1
   ```
   
   **Linux/Mac:**
   ```bash
   pip uninstall torch torchvision transformers sentence-transformers -y
   pip install "torch>=2.0.0,<2.5.0" "torchvision>=0.15.0,<0.20.0"
   pip install "transformers>=4.35.0,<5.0.0" "sentence-transformers>=2.3.0,<3.0.0"
   pip install -r requirements.txt
   ```
   
   Sinon, installez simplement:
   ```bash
   pip install -r requirements.txt
   ```

4. **Configurer les clés API**

   Éditer `Config.yaml` ou définir les variables d'environnement:
   ```bash
   export GROQ_API_KEY="your-groq-api-key"
   export GEMINI_API_KEY="your-gemini-api-key"
   ```

   Ou éditer `Config.yaml`:
   ```yaml
   groq:
     api_key: "your-groq-api-key"
   gemini:
     api_key: "your-gemini-api-key"
   ```

5. **Ajouter les Documents**

   Placer les CV des candidats dans `DATA/raw/`:
   ```bash
   DATA/
   ├── raw/
   │   ├── cv_candidat1.pdf
   │   ├── cv_candidat2.txt
   │   └── ...
   └── jobs/
       ├── offre_data_scientist.txt
       └── ...
   ```

6. **Lancer l'Application**

   **⚠️ IMPORTANT:** Utilisez Streamlit pour lancer l'application, PAS directement avec Python!
   
   ```bash
   # Option 1: Utiliser le script de démarrage
   python run.py
   
   # Option 2: Utiliser Streamlit directement
   streamlit run src/app/app.py
   
   # Option 3: Windows - Double-cliquer sur run.bat
   ```
   
   **❌ NE PAS FAIRE:** `python src/app/app.py` (cela causera des erreurs d'import)

7. **Construire l'Index RAG**

   - Cliquer sur "🚀 Initialize System" dans la sidebar
   - Cliquer sur "🔨 Build Index" pour créer l'index vectoriel
   - Commencer les évaluations!

## 📁 Structure du Projet

```
MULTI-AGENT-CANDIDATE-SELECTION/
├── Config.yaml              # Configuration
├── requirements.txt         # Dépendances Python
├── README.md               # Ce fichier
├── run.py                  # Script de démarrage rapide
├── DATA/
│   ├── raw/               # CV des candidats
│   └── jobs/              # Descriptions de poste
├── vectorstore/           # Stockage ChromaDB (créé automatiquement)
├── src/
│   ├── app/
│   │   └── app.py         # Interface Streamlit
│   ├── agents/
│   │   ├── agent_rh.py
│   │   ├── agent_profil.py
│   │   ├── agent_technique.py
│   │   ├── agent_softskills.py
│   │   └── agent_decideur.py
│   ├── rag_new/
│   │   ├── rag_system.py  # Système RAG LlamaIndex
│   │   └── __init__.py
│   ├── main.py            # Pipeline multi-agents
│   └── config.py          # Configuration
└── llm_fallback.py        # Mécanisme de fallback LLM
```

## 🎯 Utilisation

### Évaluation de Candidats

1. **Saisir la description de poste**
   - Texte manuel ou fichier depuis `DATA/jobs/`
   - Ajouter des critères supplémentaires (expérience, salaire, lieu, etc.)

2. **Lancer l'évaluation**
   - Cliquer sur "🚀 Lancer l'Évaluation"
   - Le système utilise les 5 agents pour évaluer chaque candidat

3. **Consulter les résultats**
   - Classement des candidats avec scores globaux
   - Détails par agent (Profil, Technique, Soft Skills)
   - Justifications complètes
   - Rapport final avec statistiques

### Exemple de Résultat

```
Top 3 candidats:
  1. candidat_01 - Score: 92.3/100 (FORTEMENT RECOMMANDÉ)
  2. candidat_02 - Score: 87.1/100 (RECOMMANDÉ)
  3. candidat_03 - Score: 84.5/100 (RECOMMANDÉ)

Justification candidat_01:
- Profil: Expérience adéquate (3 ans), compétences correspondantes: Python, Power BI
- Technique: Score technique: 95.0/100 (excellent, 8/8 compétences)
- Soft Skills: Excellent profil soft skills, motivation élevée
```

## ⚙️ Configuration

Éditer `Config.yaml` pour personnaliser:

- **Répertoire de données**: Où sont stockés les documents
- **Vector store**: Emplacement du stockage ChromaDB
- **Modèle d'embedding**: Modèle HuggingFace
- **Taille des chunks**: Paramètres de découpage des documents
- **Paramètres LLM**: Configuration Groq et Gemini

## 🛠️ Technologies

- **LlamaIndex**: Framework RAG pour la recherche vectorielle
- **ChromaDB**: Base de données vectorielle persistante
- **Streamlit**: Interface web interactive
- **HuggingFace**: Modèles d'embedding
- **Groq/Gemini**: Fournisseurs LLM (avec fallback automatique)

## 📝 Notes

- Le système fonctionne sans LLM (recherche de documents uniquement)
- Le LLM permet des réponses intelligentes avec génération de texte
- L'index doit être reconstruit lorsque les documents changent
- ChromaDB stocke les vecteurs de manière persistante dans `vectorstore/`
- Les agents peuvent fonctionner sans LLM (règles et heuristiques)

## 📊 Architecture du Pipeline

```
1. Agent RH → Analyse offre → Profil cible structuré
2. RAG System → Recherche candidats pertinents
3. Pour chaque candidat:
   - Agent Profil → Extraction informations CV
   - Agent Technique → Évaluation compétences techniques
   - Agent Soft Skills → Évaluation qualités interpersonnelles
4. Agent Décideur → Agrégation scores → Classement final
5. Génération rapport avec justifications
```

## 🤝 Contribution

N'hésitez pas à soumettre des issues et des demandes d'amélioration!

## 📄 Licence

Ce projet est open source et disponible pour utilisation.
