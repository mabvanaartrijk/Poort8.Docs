# Poort8 Docs Portal — **To‑Do Checklist**

> **Werkproces voor de AI‑agent**  
>
> 1. **Zoek het eerste ongevinkte vakje** in deze lijst en noteer het *Task‑ID* (bv. `S0‑1`).  
> 2. **Werk op een feature‑branch**:  
>    *Maak de branch vooraf of laat je git‑tool hem automatisch aanmaken bij de eerste commit — zolang de commit maar **niet** rechtstreeks naar `main` gaat.*  
> 3. **Open het bijbehorende Prompt‑blok** (Prompt `<Task‑ID>`) en **implementeer ALLE subtaken** volgens **Test‑Driven Development**.  
> 4. **Werk de checklist bij**: vink het vakje af in `todo.md` **op je feature‑branch**.  
> 5. **Commit & push**:  
>    ```bash
>    git add -A
>    git commit -m "<conventional commit>: <samenvatting> (<Task‑ID>)"
>    git push --set-upstream origin <feature-branch>
>    ```  
> 6. **Open een Pull Request** van deze branch naar `main`.  
> 7. **Wacht** tot **alle CI‑checks** (unit, integratie, lint, coverage, Lighthouse) **groen** zijn.  
> 8. **Merging gebeurt handmatig** (door reviewer/maintainer). *De agent merge niet.*  
> 9. Nadat de PR is gemerged en CI op `main` groen is, wordt het vakje beschouwd als voltooid.  
> 10. **Herhaal** vanaf stap 1 voor het volgende ongevinkte vakje.

> **Een vakje mag pas als voltooid gelden in `main` wanneer**  
> • de taakcode + tests in `main` zitten **én**  
> • alle CI‑pipelines daar groen zijn.
> De onderstaande geneste vakjes laten je per *sub‑taak* afvinken; een Prompt is pas klaar als **alle** sub‑vakjes daaronder afgevinkt zijn.

---

## M0 — Foundation
- [x] **S0‑1 Repo bootstrap**  
  - [x] `git init` uitvoeren  
  - [x] LICENCE (Mozilla 2025 Poort8 BV) toevoegen  
  - [x] `.editorconfig` toevoegen  
  - [x] `.gitignore` toevoegen  
- [ ] **S0‑2 Ruby pinning**  
  - [ ] `.ruby-version` met **3.3.0** aanmaken  
  - [ ] README prerequisites updaten  
- [ ] **S0‑3 Gemfile**  
  - [ ] Gemfile met Jekyll 4.3 & Minima 3 toevoegen  
  - [ ] `bundle lock --add-platform x86_64-linux` draaien  
  - [ ] `bundle install --jobs 4` draait zonder errors  
- [ ] **S0‑4 _config.yml**  
  - [ ] `_config.yml` met `title`, `url`, `theme`, lege `plugins`  
  - [ ] `bundle exec jekyll build` succesvol  
  - [ ] `_site/index.html` bestaat  

## M1 — Skeleton IA
- [ ] **S1‑1 Core pages**  
  - [ ] `index.md` met front‑matter `title`, `nav_order`  
  - [ ] `guide.md` met front‑matter  
  - [ ] `header_pages` in `_config.yml` updaten  
- [ ] **S1‑2 Product skeletons**  
  - [ ] Directories `heywim/`, `keyper/`, `noodlebar/`  
  - [ ] `index.md` in elke directory (`has_children: true`)  
- [ ] **S1‑3 Placeholders**  
  - [ ] `quick-start.md` + `faq.md` voor **HeyWim**  
  - [ ] `quick-start.md` + `faq.md` voor **Keyper**  
  - [ ] `quick-start.md` + `faq.md` voor **Noodlebar**  
  - [ ] htmlproofer zonder fouten  

## M2 — Content Drafting
- [ ] **D0 docs-todo.md**  
  - [ ] Alle huidige Markdown‑bestanden detecteren  
  - [ ] `docs-todo.md` met ongevinkte boxen genereren  
- [ ] **D1 Home‑page copy**  
  - [ ] Intro‑tekst van gebruiker vragen  
  - [ ] Placeholder in `index.md` vervangen  
  - [ ] Corresponding box in `docs-todo.md` aanvinken  
- [ ] **D2 Guide outline**  
  - [ ] Bullet‑outline bij gebruiker opvragen  
  - [ ] Insert onder `## Overview` in `guide.md`  
  - [ ] Box aanvinken in `docs-todo.md`  
- [ ] **D3 Quick‑starts**  
  - [ ] 5‑stappen quick‑start voor **HeyWim**  
  - [ ] 5‑stappen quick‑start voor **Keyper**  
  - [ ] 5‑stappen quick‑start voor **Noodlebar**  
- [ ] **D4 Context‑pagina’s**  
  - [ ] Context & actors voor **Noodlebar GIR**  
  - [ ] Context & actors voor **Noodlebar CDA**  
  - [ ] Context & actors voor **Noodlebar GDS**  
- [ ] **D5 API‑links**  
  - [ ] API‑link **HeyWim**  
  - [ ] API‑link **Keyper**  
  - [ ] API‑link **Noodlebar GIR**  
  - [ ] API‑link **Noodlebar CDA**  
  - [ ] API‑link **Noodlebar GDS**  
- [ ] **D6 Content milestone**  
  - [ ] Alle vakjes in `docs-todo.md` aangevinkt  
  - [ ] Eventueel `docs-todo.md` archiveren/verwijderen  

## M3 — Navigation & Search
- [ ] **S2‑1 jekyll-navigation**  
  - [ ] Gemfile aanvullen met `jekyll-navigation`  
  - [ ] `_plugins/jekyll-navigation.rb` toevoegen  
  - [ ] Plugin activeren in `_config.yml`  
  - [ ] `has_children: true` op alle index.md  
- [ ] **S2‑2 jekyll-lunr-js-search**  
  - [ ] Gemfile aanvullen met `jekyll-lunr-js-search`  
  - [ ] Plugin activeren in `_config.yml`  
  - [ ] `assets/js/search.js` aanmaken  
  - [ ] `_includes/search_input.html` + include in layout  
  - [ ] `search.json` template toevoegen  
- [ ] **S2‑3 Search spec**  
  - [ ] `spec_helper.rb` configureren  
  - [ ] `search_spec.rb` schrijven  
  - [ ] `bundle exec rspec` groen  

## M4 — Brand & UX Polish
- [ ] **S3‑1 Logo**  
  - [ ] `assets/images/poort8-logo.svg` (placeholder)  
  - [ ] Header include aanpassen  
- [ ] **S3‑2 Kleuren**  
  - [ ] `assets/css/custom.scss` aanmaken met kleur‑vars  
  - [ ] `_config.yml` SASS‑compress optie zetten  
- [ ] **S3‑3 Sidebar**  
  - [ ] CSS rule `.side-bar { position: fixed; … }`  

## M5 — CI & Delivery
- [ ] **S4‑1 CI‑workflow**  
  - [ ] `.github/workflows/ci.yml` met build + tests  
- [ ] **S4‑2 Deploy**  
  - [ ] Deploy‑job (`peaceiris/actions-gh-pages`) toevoegen  
  - [ ] Voorwaarde: alleen op `main`  
- [ ] **S4‑3 CNAME**  
  - [ ] `CNAME` met `docs.poort8.nl`  

## M6 — Quality Gates
- [ ] **S5‑1 Lighthouse**  
  - [ ] `.lighthouse-budget.json` creëren  
  - [ ] Workflow `lighthouse.yml` aanmaken  
- [ ] **S5‑2 Markdown‑lint**  
  - [ ] `.markdownlint.yml` toevoegen  
  - [ ] Lint‑stap in CI‑workflow  
- [ ] **S5‑3 CONTRIBUTING**  
  - [ ] `CONTRIBUTING.md` schrijven  
