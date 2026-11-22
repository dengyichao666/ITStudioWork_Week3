USE bookshop;

-- ==========================================
-- Q1：查询库存为 0 的书名和库存。
-- 预期结果/含义：只显示 stock 字段为 0 的书籍，证明找到了缺货的书。
-- ==========================================
SELECT title, stock FROM books WHERE stock = 0 ORDER BY id;

-- ==========================================
-- Q2：按价格降序取前三本，同价时按 id 升序。
-- 预期结果/含义：找出最贵的 3 本书。如果价格相同，先出版的（id小的）排在前面。
-- ==========================================
SELECT title, price FROM books ORDER BY price DESC, id ASC LIMIT 3;

-- ==========================================
-- Q3：查询价格在 20 到 40 之间的书（含边界）。
-- 预期结果/含义：查询价格 >= 20 并且 <= 40 的书籍。
-- ==========================================
SELECT title, price FROM books WHERE price BETWEEN 20 AND 40 ORDER BY price, id;

-- ==========================================
-- Q4：JOIN 查每本书的书名、作者名和价格。
-- 预期结果/含义：通过外键关联两张表，把书和它的作者对应起来展示。
-- ==========================================
SELECT b.title, a.name AS author_name, b.price
FROM books AS b
JOIN authors AS a ON b.author_id = a.id
ORDER BY b.id;

-- ==========================================
-- Q5：先 SELECT 确认，再把指定一本有库存的书库存减 1（不要减成负数）。
-- 预期结果/含义：先查出 id=1 的《三体》当前库存，然后将其库存减 1。
-- 注意：这里的 WHERE 条件带了 stock > 0，保证不会减成负数。
-- ==========================================
-- 第一步：SELECT 确认
SELECT id, title, stock FROM books WHERE id = 1;
-- 第二步：UPDATE 修改
UPDATE books SET stock = stock - 1 WHERE id = 1 AND stock > 0;

-- ==========================================
-- Q6：插入一条唯一标记的临时书，确认后按条件删除它，不删除其他书。
-- 预期结果/含义：新增一本临时书，查出来看看，然后再删掉它，保证不影响其他数据。
-- ==========================================
-- 第一步：INSERT 插入
INSERT INTO books (title, author_id, price, stock) VALUES ('【测试用临时书】', 1, 99.99, 1);
-- 第二步：SELECT 确认
SELECT * FROM books WHERE title = '【测试用临时书】';
-- 第三步：DELETE 删除
DELETE FROM books WHERE title = '【测试用临时书】';