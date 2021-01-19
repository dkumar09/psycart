--USERS TABLE
CREATE TABLE `psycart`.`User`(
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `firstName` VARCHAR(50) NULL DEFAULT NULL,
    `middleName` VARCHAR(50) NULL DEFAULT NULL,
    `lastName` VARCHAR(50) NULL DEFAULT NULL,
    `email` VARCHAR(50) NULL,
    `mobile` VARCHAR(10) NULL,
    `passwordHash` VARCHAR(32),
    `salt` VARCHAR(16),
    `admin` TINYINT(1) NOT NULL DEFAULT 0,
    `vendor` TINYINT(1) NOT NULL DEFAULT 0,
    `registeredAt` DATETIME NOT NULL,
    `lastLogin` DATETIME NULL DEFAULT NULL,
    `intro` TINYTEXT NULL DEFAULT NULL,
    `Profile` TEXT NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `uq_mobile` (`mobile` ASC),
    UNIQUE INDEX `uq_email` (`email` ASC)
);
--PRODUCT TABLE
CREATE TABLE `psycart`.`product`(
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `userId` BIGINT NOT NULL,
    `title` VARCHAR(75) NOT NULL,
    `megaTitle` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `summmary` TINYTEXT NULL,
    `type` SMALLINT(6) NOT NULL DEFAULT 0,
    `sku` VARCHAR(100) NOT NULL,
    `price` FLOAT NOT NULL DEFAULT 0,
    `discount` FLOAT NOT NULL DEFAULT 0,
    `quantity`SMALLINT(6) NOT NULL DEFAULT 0,
    `shop` TINYINT(1) NOT NULL DEFAULT 0,
    `createdAt` DATETIME NOT NULL,
    `updatedAt` DATETIME NULL DEFAULT NULL,
    `publishedAt` DATETIME NULL DEFAULT NULL,
    `startsAt` DATETIME NULL DEFAULT NULL,
    `endsAt` DATETIME NULL DEFAULT NULL,
    `content` TEXT NULL DEFAULT NULL,
    PRIMARY KEY(`id`),
    UNIQUE INDEX `uq_slug`  (`slug` ASC),
    INDEX `idx_product_user`) (`userId` ASC),
    CONSTRAINT `fk_product_user`
        FOREIGN KEY (`userId`)
        REFERENCES `psycart`.`user` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
--PRODUCT META
CREATE TABLE `psycart`.`product_meta`(
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `productId` BIGINT NOT  NULL,
    `key` VARCHAR(50) NOT NULL,
    `conten` text NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `idx_meta_product` (`id` ASC),
    UNIQUE INDEX `uq_meta_product`(`productId` ASC, `key` ASC),
    CONSTRAINT `fk_meta_produt`
        FOREIGN KEY (`productId`)
        REFERENCES `psycart`.`product` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
ENGINE = InnoDB;
--PRODUCT REVIEW
CREATE TABLE `psycart`.`product_review`(
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `productId` BIGINT NOT NULL,
    `parentId` BIGINT NULL DEFAULT NULL,
    `title` VARCHAR(100) NOT NULL,
    `rating` SMALLINT(6) NOT NULL DEFAULT 0,
    `published` TINYINT(2) NOT NULL DEFAULT 0,
    `createdAt` DATETIME NOT NULL,
    `publishedAt` DATETIME NULL DEFAULT NULL,
    `content` TEXT NULL DEFAULT NULL,
    PRIMARY KEY(`id`),
    INDEX `idx_review_product` (`productId` ASC),
    CONSTRAINT `fk_review_product`
    FOREIGN KEY(`productId`)
    REFERENCES `psycart`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
ALTER TABLE `psycart`.`product_review`
ADD INDEX  `idx_review_parent` (`parentID` ASC);
ALTER TABLE `psycart`.`product_review`
ADD CONSTRAINT 