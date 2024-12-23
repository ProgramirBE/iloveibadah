﻿using IbadahLover.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IbadahLover.Application.Contracts.Identity
{
    public interface IUserService
    {
        Task<List<UserAccount>> GetUserAccounts();
        Task<UserAccount> GetUserAccount(int id);
    }
}
