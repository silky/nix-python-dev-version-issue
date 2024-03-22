# Quirk

Demonstrates a quirk with the `.dev` version term and nix.

To reproduce:

```shell
nix develop
```

Error:

```
       > Checking runtime dependencies for this-1-py3-none-any.whl
       >   - other not satisfied by version 1.dev1
```

Then change the version in `./other` to be simply `1`, and it works.
