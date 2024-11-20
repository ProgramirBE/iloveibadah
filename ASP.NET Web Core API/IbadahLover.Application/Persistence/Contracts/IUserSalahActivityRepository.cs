﻿using IbadahLover.Domain;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IbadahLover.Application.Persistence.Contracts
{
    // Repository of All SQL Methods for UserSalahActivity Entity
    public interface IUserSalahActivityRepository : IGenericRepository<UserSalahActivity>
    {
        Task<UserSalahActivity> GetUserSalahActivityWithDetails(int id);
        Task<List<UserSalahActivity>> GetUserSalahActivitiesWithDetails();
        [DataType(DataType.Date)]
        Task<bool> PerformedOnExists(int id, DateTime performedOn);
    }
}
