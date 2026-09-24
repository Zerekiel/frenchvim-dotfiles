# 💤 Frenchvim Configuration

## 🚀 Philosophy
This is an opinionated Nvim configuration based on what i use in my everyday work.  
It's not meant to work for everyone.  
Feel free to fork and make it your own 
Each plugin is grouped according to its purpose, keeping the configuration modular and making the entire setup easier to understand, customize, and maintain.  

## 📋 Prerequisites

| Requirement | Version |
|---|---|
| Neovim | `>= 0.12.0` |
| Git | `>= 2.19.0` |
| ripgrep | latest |
| fd | latest |
| Nerd Font | recommended |
| C compiler | gcc / clang |


Following is the plugin list organized by categories

```text
📁 src/
│
├─ 🎨 display/      UI & visual enhancements
├─ ✏️ editor/       Editing & completion
├─ 🔀 git/          Git integration
├─ 🧩 language/      Language-specific tooling
├─ 🔧 lsp/          LSP, diagnostics & dev tools
├─ ✨ qol/          Quality-of-life improvements
├─ 🧭 roaming/      Navigation & search
├─ 🖥️ terminal/    Integrated terminal
└─ 🎭 themes/      Themes & icons
```

## 🎨 Display

Plugins related to Neovim's interface and visual experience.

| File | Description |
|---|---|
| `alpha.lua` | Provides a customizable dashboard displayed when starting Neovim. |
| `bufferline.lua` | Displays and provides navigation between open buffers using a tab-like interface. |
| `colorizer.lua` | Displays colors directly in the editor for values such as hex, RGB, and other color formats. |
| `lualine.lua` | Provides a customizable statusline displaying useful information about the current Neovim state. |
| `mini-bufremove.lua` | Provides a clean way to remove buffers without unnecessarily closing their associated windows. |
| `minimap.lua` | Adds a minimap to get an overview of the current file. |
| `render-markdown.lua` | Improves the visual rendering of Markdown files directly inside Neovim. |
| `scrollbar.lua` | Adds a scrollbar indicating the current position within the file. |

---

## ✏️ Editor

Plugins focused on improving code editing and writing.

| File | Description |
|---|---|
| `autopairs.lua` | Automatically closes brackets, parentheses, braces, quotes, and other pairs. |
| `comments.lua` | Makes creating and managing code comments easier. |
| `conform.lua` | Handles code formatting and integrates external formatters into Neovim. |
| `nvim-cmp.lua` | Provides an advanced completion engine for code, snippets, buffers, paths, and other sources. |
| `todo-comments.lua` | Highlights comments such as `TODO`, `FIXME`, `HACK`, and similar annotations. |
| `treesitter.lua` | Provides advanced syntax parsing for better highlighting, indentation, code navigation, and other language-aware features. |

---

## 🔀 Git

Git integration directly inside Neovim.

| File | Description |
|---|---|
| `blame.lua` | Displays Git blame information directly inside the editor. |
| `git-conflict.lua` | Helps detect and resolve Git merge conflicts directly from Neovim. |
| `gitsigns.lua` | Displays Git changes in the sign column and provides various Git-related actions. |
| `lazygit.lua` | Integrates Lazygit into Neovim for a terminal-based Git workflow. |

---

## 🌐 Language

Tools dedicated to specific languages and development environments.

| File | Description |
|---|---|
| `ts-error-translator.lua` | Translates and simplifies TypeScript errors to make them easier to understand. |
| `tsc.lua` | Integrates the TypeScript compiler (`tsc`) into the Neovim workflow. |

---

## 🧠 LSP

Configuration and tools related to the **Language Server Protocol**.

| File | Description |
|---|---|
| `glance.lua` | Provides an interface for exploring definitions, references, implementations, and symbols. |
| `lsp.lua` | Main configuration for the LSP and language servers. |
| `mason.lua` | Manages the installation of LSP servers, linters, formatters, and other external development tools. |
| `nvim-lint.lua` | Integrates external linters to analyze code and report potential issues. |
| `tiny-inline-diagnostic.lua` | Displays LSP diagnostics directly inline in the code using a compact interface. |

---

## ⚡ QoL

Quality-of-life tools designed to improve the daily workflow.

| File | Description |
|---|---|
| `persistence.lua` | Automatically saves and restores Neovim sessions. |
| `snacks.lua` | Provides a collection of utilities and features that enhance different aspects of Neovim. |
| `whichkey.lua` | Displays available keybindings when starting to type a key combination. |

---

## 🗂️ Roaming

Plugins focused on project navigation and search.

| File | Description |
|---|---|
| `neo-tree.lua` | Provides a file explorer for navigating the project's directory structure. |
| `telescope.lua` | Provides fuzzy finding for quickly searching files, buffers, symbols, references, and more. |

---

## 🖥️ Terminal

Terminal management directly inside Neovim.

| File | Description |
|---|---|
| `floaterm.lua` | Provides a floating terminal that can be opened directly from Neovim. |

---

## 🎨 Themes

Plugins related to the editor's theme and icons.

| File | Description |
|---|---|
| `ayu.lua` | Provides the Ayu theme for customizing Neovim's appearance. |
| `real-icons.lua` | Improves icon support across the Neovim interface and various plugins. |


