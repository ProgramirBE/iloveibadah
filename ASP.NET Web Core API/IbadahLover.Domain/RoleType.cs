﻿using IbadahLover.Domain.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IbadahLover.Domain
{
    public class RoleType : BaseDomainEntity
    {
        public string FullName { get; set; }
        public string Details { get; set; }
    }
}
