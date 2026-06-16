# tests/

Test Cloud test-case specifications for the **owlgate-sample-app** System Under Test.

Each spec is the contract the Risk agent selects from and the Self-Healing agent
repairs. Specs are grouped by surface:

- `ui/` — browser test cases (the fragile selectors live here).
- `api/` — API test cases against the sample app's backend.

See [`ui/contact-form.spec.md`](./ui/contact-form.spec.md) for the format.
