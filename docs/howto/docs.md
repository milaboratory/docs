## Features

### UML

Flavour / docs: [plantuml](https://plantuml.com/sequence-diagram)

see markdown specific options: [here](https://github.com/mikitex70/plantuml-markdown)

#### Syntax

```plantuml
Goofy ->  MickeyMouse: calls
Goofy <-- MickeyMouse: responds
```

````markdown
```plantuml
Goofy ->  MickeyMouse: calls
Goofy <-- MickeyMouse: responds
```
````

[//]: # (Flavour / docs: [mermaid]&#40;https://mermaid-js.github.io/mermaid/#/&#41;)

[//]: # ()
[//]: # (Additional examples: [here]&#40;https://squidfunk.github.io/mkdocs-material/reference/diagrams/&#41;)

[//]: # ()
[//]: # (```mermaid)

[//]: # (graph LR)

[//]: # (  A[Start] --> B{Error?};)

[//]: # (  B -->|Yes| C[Hmm...];)

[//]: # (  C --> D[Debug];)

[//]: # (  D --> B;)

[//]: # (  B ---->|No| E[Yay!];)

[//]: # (```)

### Equations

Rendered by: [katex](https://katex.org/)

#### Inline mode

Lorem ipsum $`c = \pm\sqrt{a^2 + b^2}`$

```markdown
Lorem ipsum $`c = \pm\sqrt{a^2 + b^2}`$
```

#### Block mode

Block
```math
c = \pm\sqrt{a^2 + b^2}
```

````markdown
Block
```math
c = \pm\sqrt{a^2 + b^2}
```
````

## Testing the docs on your machine

> :warning: Don't forget to add a record for the file you've added to the `nav` section in the `mkdocs.yml` file

You need a working Python / pip installation. Good luck if you have a screwed up environment!

```shell
git clone git@github.com:milaboratory/internal-documentation.git
cd internal-documentation
pip install -r requirements.txt
mkdocs serve
```

Open your browser at: [http://127.0.0.1:8000/](http://127.0.0.1:8000/)
