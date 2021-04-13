SELECT id, student FROM public.seat;

-- Move up by one wnen the id is odd, move down by one when id is even
-- Makes no changes to last column if total number is odd

SELECT 
(CASE WHEN MOD(id,2) != 0 AND id = tc THEN id
WHEN MOD(id,2) != 0 THEN id+1
ELSE id-1 END) as id,
student
FROM public.seat, (SELECT COUNT(*) as tc FROM public.seat ) as total_count
ORDER BY id;
