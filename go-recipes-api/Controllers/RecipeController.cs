using GoRecipesApi.Dtos;
using GoRecipesApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GoRecipesApi.Controllers;

[ApiController]
[Route("api/recipes")]
public class RecipeController : ControllerBase
{
    private readonly RecipeContext _context;
    
    public RecipeController(RecipeContext context)
    {
        _context = context;
    }

    [HttpGet(Name = "GetRecipe")]
    public async Task<ActionResult<IEnumerable<RecipeDto>>> GetRecipe()
    {
        return await _context.Recipes
            .Include(r => r.Ingredients)
            .Include(r => r.Steps)
            .Select(r => new RecipeDto
            {
                RecipeId = r.RecipeId,
                Name = r.Name,
                Description = r.Description,
                CreationDate = r.CreationDate,
                PreparationTime = r.PreparationTime,
                Rating = r.Rating ?? 0,
                Ingredients = r.Ingredients.Select(i => new RecipeIngredientDto
                {
                    Ingredient = i.Ingredient
                }).ToList(),
                Steps = r.Steps.Select(s => new RecipeStepDto
                {
                    StepNumber = s.StepNumber,
                    StepDescription = s.StepDescription
                }).ToList()
            })
            .ToListAsync();
    }
}