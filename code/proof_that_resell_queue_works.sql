SELECT 
    v.id_visitor,
    v.first_name,
    v.last_name,
    v.phone,
    v.email,
    v.age,
    t.code_ean13
FROM 
    visitor v
JOIN 
    ticket t ON v.id_visitor = t.id_visitor
WHERE 
    t.code_ean13 IN (
        6691080631165,
        7414390806281,
        8083025929778,
        9300645588217,
        4278116290766,
        1739332915472,
        7290616015421,
        4844258214331,
        5880624541509,
        2549327664227
    );
