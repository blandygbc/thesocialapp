import { Request, Response } from "express";
import { getCustomRepository } from "typeorm";
import { StoryRepository } from "../database/repository/stoy.repository";

export class StoryController {
    static async storyAdd(req: Request, res: Response) {
        let storyRepository = getCustomRepository(StoryRepository);
        await storyRepository.storyAdd(req, res);
    }

    static async storyDelete(req: Request, res: Response) {
        let storyRepository = getCustomRepository(StoryRepository);
        await storyRepository.storyDelete(req, res);
    }
    static async storyFindAll(req: Request, res: Response) {
        let storyRepository = getCustomRepository(StoryRepository);
        await storyRepository.storyFindAll(req, res);
    }

    static async storyFindAllByUser(req: Request, res: Response) {
        let storyRepository = getCustomRepository(StoryRepository);
        await storyRepository.storyFindAllByUser(req, res);
    }
    static async storyFindOne(req: Request, res: Response) {
        let storyRepository = getCustomRepository(StoryRepository);
        await storyRepository.storyFindOne(req, res);
    }
}