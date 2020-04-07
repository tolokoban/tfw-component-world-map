#! /usr/bin/awk -f

BEGIN {
    FS = "="
}

/data-name="/ { name = $2 }
/data-id="/ { id = substr($2, 2, 2) }
/[ \t]d="/ { print id ":[" name "," $2 "]," }

