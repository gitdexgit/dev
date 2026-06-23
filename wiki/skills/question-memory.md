---
name: question-memory
description: "Pointer-based memory system using question-named files."
version: 1.0.0
author: Hermes
metadata:
  hermes:
    tags: [memory, wiki, optimization, context-management]
---

# Question-Memory (Pointer Pattern)

This skill implements a high-efficiency memory retrieval system where information is stored in files named after the specific questions they answer. 

## The Concept
Instead of loading a massive flat `MEMORY.md` file, the agent uses directory listings (`ls`) as a "semantic hash table". 

- **Key**: The filename (The Question).
- **Pointer**: The existence of the file.
- **Value**: The file content (The Answer).

## Workflow

### 1. Discovery (The Pointer Scan)
Before asking the user for information or searching deep context, run:
```bash
ls ~/.hermes/wiki
```
Scan the filenames. If a filename matches or is highly relevant to the current task, proceed to Step 2.

### 2. Selective Load
Only use `read_file` on the specific matched "question-pointer". This keeps the context window clean.

### 3. Hierarchical Folders (Sub-Questions)
When a topic grows to 3+ related files:
1. Create a subdirectory named after the category/high-level question (e.g., `~/.hermes/wiki/hermes/`).
2. Move specific question files into that directory.
3. (Optional) Create a matching `.md` file in the root (e.g., `~/.hermes/wiki/hermes.md`) that summarizes the category or links to the most important sub-questions.

This structure allows the initial `ls ~/.hermes/wiki` to remain flat and fast, while providing a clear path to drill down into specific knowledge clusters.

## Storage
Always store new durable facts in `~/.hermes/wiki/`.
- Root level for unique/new topics.
- Subdirectories for established categories.

Example:
`~/.hermes/wiki/git/`
`~/.hermes/wiki/git/how to handle large file locks.md`
`~/.hermes/wiki/git/how to recover lost commits.md`

## Benefits
- **Zero Token Cost**: Directory listings are essentially free.
- **Perfect Retrieval**: Filenames are indexed by the OS/Filesystem.
- **Scalability**: Can hold thousands of facts without ever bloating the prompt.
