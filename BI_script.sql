select
    s.manager_id,
    m.full_name,
    sum(s.amount) as revenue,
    sum(s.amount - p.cost * s.quantity) as margin,
    sum(s.amount) * 1.0 / count(distinct s.client_id) as avg_check
from 
	sales s
join 
	products p on p.product_id = s.product_id
join 
	managers m on m.manager_id = s.manager_id
where 
	s.sale_date between '2025-09-01' and '2025-09-30'
group by 
	s.manager_id,
	m.full_name
order by 
	m.full_name;


select
    mp.manager_id,
    m.full_name,
    mp.revenue_plan,
    mp.margin_plan,
    mp.avg_check_plan
from 
	manager_plans mp
join 
	managers m on m.manager_id = mp.manager_id
where 
	mp.period_start = '2025-09-01'
	and mp.period_end   = '2025-09-30'
order by 
	m.full_name;


select
    s.manager_id,
    m.full_name,
    p.category,
    sum(s.amount) as revenue
from 
	sales s
join 
	products p on p.product_id = s.product_id
join 
	managers m on m.manager_id = s.manager_id
where 
	s.sale_date between '2025-09-01' and '2025-09-30'
group by 
	s.manager_id,
	m.full_name,
	p.category
order by 
	s.manager_id, revenue desc;


select
    s.manager_id,
    m.full_name,
    p.article,
    sum(s.amount) as revenue
from 
	sales s
join
	products p on p.product_id = s.product_id
join
	managers m on m.manager_id = s.manager_id
where
	s.sale_date between '2025-09-01' and '2025-09-30'
group by
	s.manager_id, 
	m.full_name,
	p.article
order by
	s.manager_id,
	revenue desc;


select
    t.team_lead_id,
    m.full_name as team_lead,
    sum(s.amount) as revenue,
    sum(s.amount - p.cost * s.quantity) as margin
from 
	sales s
join 
	products p  on p.product_id = s.product_id
join
	team_members tm on tm.manager_id = s.manager_id
join
	teams t on t.team_id = tm.team_id
join 
	managers m on m.manager_id = t.team_lead_id
where 
	tm.role_in_team = 'manager'
	and s.sale_date between '2025-09-01' and '2025-09-30'
group by
	t.team_lead_id,
	m.full_name
order by
	revenue desc;


select
    t.team_lead_id,
    lead.full_name as team_lead,
    p.category,
    sum(s.amount) as revenue
from 
	sales s
join 
	products p on p.product_id = s.product_id
join
	team_members tm on tm.manager_id = s.manager_id
join
	teams t on t.team_id = tm.team_id
join
	managers lead on lead.manager_id = t.team_lead_id
where
	tm.role_in_team = 'manager'
group by
    t.team_lead_id,
    lead.full_name,
    p.category
order by
    team_lead,
    revenue desc;


select
    t.team_lead_id,
    lead.full_name as team_lead,
    p.article,
    sum(s.amount) as revenue
from sales s
join 
	products p on p.product_id = s.product_id
join
	team_members tm on tm.manager_id = s.manager_id
join
	teams t on t.team_id = tm.team_id
join
	managers lead on lead.manager_id = t.team_lead_id
where
	tm.role_in_team = 'manager'
group by
    t.team_lead_id,
    lead.full_name,
    p.article
order by
    team_lead,
    revenue desc

