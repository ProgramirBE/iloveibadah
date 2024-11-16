﻿using IbadahLover.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IbadahLover.Application.Persistence.Contracts
{
    // Repository of All SQL Methods for UserDhikrOverview Entity
    public interface IUserDhikrOverviewRepository : IGenericRepository<UserDhikrOverview>
    {
        Task<UserDhikrOverview> GetUserDhikrOverviewWithDetails(int id);
        Task<List<UserDhikrOverview>> GetUserDhikrOverviewsWithDetails();
    }
}
