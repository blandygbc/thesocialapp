import { BaseEntity, Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { UserEntity } from "./user.entity";

@Entity("story")
export class StoryEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    story_id!: number;

    @Column({
        type: "simple-array",
        nullable: false,
    })
    story_assets!: string[];

    @Column({
        type: "timestamp",
        default: () => "CURRENT_TIMESTAMP(6)",
        nullable: false,
    })
    story_date!: Date;

    @ManyToOne(() => UserEntity, (story_user) => story_user.user_story)
    @JoinColumn()
    story_user!: UserEntity;

    @OneToMany(() => StoryEntity, (user_story) => user_story.story_user)
    @JoinColumn()
    user_story!: StoryEntity[];
}