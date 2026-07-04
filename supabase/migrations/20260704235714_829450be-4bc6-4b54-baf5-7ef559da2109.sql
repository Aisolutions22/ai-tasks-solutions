REVOKE SELECT (email) ON public.profiles FROM authenticated, anon;

REVOKE EXECUTE ON FUNCTION public.get_profile_emails() FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION public.is_admin_only() FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION public.is_admin_or_owner() FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION public.is_assigned_to_task(uuid) FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION public.get_my_profile_id() FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION public.get_my_role() FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION public.prevent_task_assignment_key_change() FROM PUBLIC, anon, authenticated;

GRANT EXECUTE ON FUNCTION public.get_profile_emails() TO authenticated;
GRANT EXECUTE ON FUNCTION public.is_admin_only() TO authenticated;
GRANT EXECUTE ON FUNCTION public.is_admin_or_owner() TO authenticated;
GRANT EXECUTE ON FUNCTION public.is_assigned_to_task(uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_my_profile_id() TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_my_role() TO authenticated;