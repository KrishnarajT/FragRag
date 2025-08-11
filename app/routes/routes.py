from fastapi import APIRouter

router = APIRouter()


@router.get("/entities")
def get_entities():
    return []


@router.get("/relationships")
def get_relationships():
    return []
