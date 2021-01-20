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
    `psycart` TINYINT(1) NOT NULL DEFAULT 0,
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
    `published` TINYINT(1) NOT NULL DEFAULT 0,
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
ADD    INDEX  `idx_review_parent` (`parentId` ASC);
ALTER TABLE `psycart`.`product_review`
ADD CONSTRAINT `psycart`.`fk_review_product`
    FOREIGN KEY (`parentId`)
    REFERENCES `psycart`.`product_review` (`id`)
    ON DELETE NO ACTION
    On UPDATE NO ACTION
;
--CATEGORY TABLE

CREATE TABLE `psycart`.`category`(
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `parentId` BIGINT NULL DEFAULT NULL,
    `title` VARCHAR(75) NOT NULL,
    `metaTitle` VARCHAR(100) NULL DEFAULT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `content` TEXT NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
);
ALTER TABLE `psycart`.`category`
ADD INDEX `idx_category_parent` (`parentId` ASC);
ALTER TABLE `psycart`.`category`
ADD CONSTRAINT `fk_category_parent`
    FOREIGN KEY(`parentId`)
    REFERENCES `psycart`.`category`(`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--PRODUCT CATEGORY

CREATE TABLE `psycart`.`product_category`(
    `productId` BIGINT NOT NULL,
    `categoryId` BIGINT NOT NULL,
    PRIMARY KEY(`productId`,`categoryId`),
    INDEX `idx_pc_category` (`categoryId` ASC),
    INDEX `idx_pc_product` (`productId` ASC),
    CONSTRAINT `fk_pc_product`
        FOREIGN KEY(`productId`)
        REFERENCES `psycart`.`product` (`id`)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT `fk_pc_category`
        FOREIGN KEY(`categoryId`)
        REFERENCES `psycart`.`category`(`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

--CART TABLE
CREATE TABLE `psycart`.`cart` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NULL DEFAULT NULL,
  `sessionId` VARCHAR(100) NOT NULL,
  `token` VARCHAR(100) NOT NULL,
  `status` SMALLINT(6) NOT NULL DEFAULT 0,
  `firstName` VARCHAR(50) NULL DEFAULT NULL,
  `middleName` VARCHAR(50) NULL DEFAULT NULL,
  `lastName` VARCHAR(50) NULL DEFAULT NULL,
  `mobile` VARCHAR(15) NULL,
  `email` VARCHAR(50) NULL,
  `line1` VARCHAR(50) NULL DEFAULT NULL,
  `line2` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `province` VARCHAR(50) NULL DEFAULT NULL,
  `country` VARCHAR(50) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_cart_user` (`userId` ASC),
  CONSTRAINT `fk_cart_user`
    FOREIGN KEY (`userId`)
    REFERENCES `psycart`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
--CART ITEM
CREATE TABLE `psycart`.`cart_item`(
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `productId` BIGINT NOT NULL,
    `cartId` BIGINT NOT NULL,
    `sku` VARCHAR(100) NOT NULL,
    `price` FLOAT NOT NULL DEFAULT 0,
    `discount` FLOAT NOT NULL DEFAULT 0,
    `quantity` SMALLINT(6) NOT NULL DEFAULT 0,
    `active` TINYINT(1) NOT NULL DEFAULT 0,
    `createdAt` DATETIME NOT NULL,
    `updatedAt` DATETIME NOT NULL,
    `content` TEXT NULL DEFAULT NULL,
    PRIMARY KEY(`id`),
    INDEX `idx_cart_item_product` (`productId` ASC),
    CONSTRAINT `fk_cart_item_product`
        FOREIGN KEY(`productId`)
        REFERENCES `psycart`.`product` (`id`)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE `psycart`.`cart_items`
ADD INDEX `idx_cart_item_cart` (`cartId` ASC);
ALTER TABLE `psycart`.`cart_item`
ADD CONSTRAINT `fk_cart_item_cart`
    FOREIGN KEY(`cartId`)
    REFERENCES `psycart`.`cart` (`id`)
    ON UPDATE NO ACTION
    On DELETE NO ACTION;

--ORDER
CREATE TABLE `psycart`.`order` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NULL DEFAULT NULL,
  `sessionId` VARCHAR(100) NOT NULL,
  `token` VARCHAR(100) NOT NULL,
  `status` SMALLINT(6) NOT NULL DEFAULT 0,
  `subTotal` FLOAT NOT NULL DEFAULT 0,
  `itemDiscount` FLOAT NOT NULL DEFAULT 0,
  `tax` FLOAT NOT NULL DEFAULT 0,
  `shipping` FLOAT NOT NULL DEFAULT 0,
  `total` FLOAT NOT NULL DEFAULT 0,
  `promo` VARCHAR(50) NULL DEFAULT NULL,
  `discount` FLOAT NOT NULL DEFAULT 0,
  `grandTotal` FLOAT NOT NULL DEFAULT 0,
  `firstName` VARCHAR(50) NULL DEFAULT NULL,
  `middleName` VARCHAR(50) NULL DEFAULT NULL,
  `lastName` VARCHAR(50) NULL DEFAULT NULL,
  `mobile` VARCHAR(15) NULL,
  `email` VARCHAR(50) NULL,
  `line1` VARCHAR(50) NULL DEFAULT NULL,
  `line2` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `province` VARCHAR(50) NULL DEFAULT NULL,
  `country` VARCHAR(50) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_order_user` (`userId` ASC),
  CONSTRAINT `fk_order_user`
    FOREIGN KEY (`userId`)
    REFERENCES `psycart`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `psycart`.`order_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `productId` BIGINT NOT NULL,
  `orderId` BIGINT NOT NULL,
  `sku` VARCHAR(100) NOT NULL,
  `price` FLOAT NOT NULL DEFAULT 0,
  `discount` FLOAT NOT NULL DEFAULT 0,
  `quantity` SMALLINT(6) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_order_item_product` (`productId` ASC),
  CONSTRAINT `fk_order_item_product`
    FOREIGN KEY (`productId`)
    REFERENCES `psycart`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `psycart`.`order_item` 
ADD INDEX `idx_order_item_order` (`orderId` ASC);
ALTER TABLE `psycart`.`order_item` 
ADD CONSTRAINT `fk_order_item_order`
  FOREIGN KEY (`orderId`)
  REFERENCES `psycart`.`order` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
--TRANSACTION
CREATE TABLE `psycart`.`transaction` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NOT NULL,
  `orderId` BIGINT NOT NULL,
  `code` VARCHAR(100) NOT NULL,
  `type` SMALLINT(6) NOT NULL DEFAULT 0,
  `mode` SMALLINT(6) NOT NULL DEFAULT 0,
  `status` SMALLINT(6) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_transaction_user` (`userId` ASC),
  CONSTRAINT `fk_transaction_user`
    FOREIGN KEY (`userId`)
    REFERENCES `psycart`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `psycart`.`transaction` 
ADD INDEX `idx_transaction_order` (`orderId` ASC);
ALTER TABLE `psycart`.`transaction` 
ADD CONSTRAINT `fk_transaction_order`
  FOREIGN KEY (`orderId`)
  REFERENCES `psycart`.`order` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;