-- Create the main Recipe table
CREATE TABLE Recipes
(
    RecipeId        INT IDENTITY (1,1) PRIMARY KEY,
    Name            NVARCHAR(255) NOT NULL,
    Description     NVARCHAR(MAX),
    CreationDate    DATETIME DEFAULT GETDATE(),
    PreparationTime INT, -- stored in minutes
    Rating          TINYINT NULL
);

-- Create table for ingredients. Each ingredient is linked to a recipe. The recipe is default for 2 portions
CREATE TABLE RecipeIngredients
(
    IngredientId INT IDENTITY (1,1) PRIMARY KEY,
    RecipeId     INT FOREIGN KEY REFERENCES Recipes (RecipeId),
    Ingredient   NVARCHAR(255) NOT NULL,
    Amount INT NOT NULL,
    Metric NVARCHAR(50) NULL
);

-- Create table for steps
CREATE TABLE RecipeSteps
(
    StepId          INT IDENTITY (1,1) PRIMARY KEY,
    RecipeId        INT FOREIGN KEY REFERENCES Recipes (RecipeId),
    StepNumber      INT           NOT NULL,
    StepDescription NVARCHAR(MAX) NOT NULL,
);

-- Create indexes for better performance
CREATE INDEX IX_RecipeIngredients_RecipeId ON RecipeIngredients (RecipeId);
CREATE INDEX IX_RecipeSteps_RecipeId ON RecipeSteps (RecipeId);

ALTER TABLE Recipes ADD CONSTRAINT CK_Recipes_Rating_1_10 CHECK (Rating BETWEEN 1 AND 10);