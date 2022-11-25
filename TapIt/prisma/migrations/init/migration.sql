-- CreateTable
CREATE TABLE "emergency" (
    "em_id" BIGINT NOT NULL,
    "type" VARCHAR(50) NOT NULL,
    "source" DOUBLE PRECISION[],
    "destination" DOUBLE PRECISION[],
    "status" VARCHAR(50),
    "description" VARCHAR(255),
    "id" BIGINT NOT NULL,

    CONSTRAINT "emergency_pkey" PRIMARY KEY ("em_id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255),
    "email" VARCHAR(255),
    "phone" BIGINT,
    "age" INTEGER,
    "blood" VARCHAR(3),
    "height" DOUBLE PRECISION,
    "gender" CHAR(1),
    "address" VARCHAR(255),
    "phonelist" BIGINT[],

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "emergency" ADD CONSTRAINT "id" FOREIGN KEY ("id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

