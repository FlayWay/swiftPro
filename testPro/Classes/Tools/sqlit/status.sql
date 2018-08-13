--创建数据表----
CREATE TABLE  IF NOT EXISTS "status" (
    "statusid" integer,
    "userid" integer,
    "status" text,
    "createTime" text DEFAULT (datetime('now','localtime')),
    PRIMARY KEY ("statusid", "userid")
);
