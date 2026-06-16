# Test spec — Contact form (UI)

> Format note: this is a human-readable spec. The actual executable test lives in
> Test Cloud; this file is the source-of-truth the agents reason over.

| Field | Value |
| :--- | :--- |
| **Suite** | `ui/contact-form` |
| **Surface** | Web UI (sample-app frontend) |
| **Risk tags** | `validation`, `form`, `submit` |
| **Maps to source** | `owlgate-sample-app/src/routes/contact/+page.svelte`, `.../api/contacts` |

## Steps

1. Open `/contact`.
2. Fill **Name** with `Ada Lovelace`.
3. Fill **Email** with `ada@example.com`.
4. Click **Submit**.
5. Assert a success toast with text `Thanks, we'll be in touch`.

## Known fragility (intentional)

- **Fragile selector** — step 5 targets the toast by a brittle locator that breaks
  when the label changes. *Self-Healing agent target.*
- **Flaky timing** — the success toast animates in; a too-short wait makes this
  flaky. *Flaky-detection target.*
