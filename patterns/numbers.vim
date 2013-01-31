call vrs#set('_ip4_segment', '\%(25[0-5]\|2[0-4]\d\|[01]\?\d\d\?\)')
call vrs#set('ip4',          '\<' . join(repeat([vrs#get('_ip4_segment')], 4), '\.') . '\>')
